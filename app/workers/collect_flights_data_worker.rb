class CollectFlightsDataWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5
  UNKNOWN_FLIGHT_STATUS = 'no_data'.freeze

  def initialize(claim_repository: ::ClaimRepository.new,
                  update_flights: UpdateFlightsDataWorker,
                  check_claim_eligibility: ::Services::V1::CheckClaimEligibility.new,
                  flights_requests: ::Services::V1::Request::BulkCollectFlightData.new)
    @claim_repository = claim_repository
    @update_flights = update_flights
    @check_claim_eligibility = check_claim_eligibility
    @flights_requests = flights_requests
  end

  def perform(claim_id)
    claim = @claim_repository.get_claim_with_flights(claim_id)
    flights = claim.flights
    if flights.any? {|flight| flight.flight_status == UNKNOWN_FLIGHT_STATUS }
      update_flights(claim_id, flights)
    else
      @check_claim_eligibility.call(claim_id)
    end
  end

  private

  def update_flights(claim_id, flights)
    results = run_requests(flights.pluck(:flight_identifier))
    @update_flights.perform_in(1, claim_id, results) if results.all? { |result| result.any? }
  end

  def run_requests(flights_idenfifiers)
    @flights_requests.call(flights_idenfifiers)
  end
end
