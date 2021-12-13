class UpdateFlightsDataWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def initialize(flight_repository: ::FlightRepository.new, check_claim_eligibility: ::Services::V1::CheckClaimEligibility.new)
    @flight_repository = flight_repository
    @check_claim_eligibility = check_claim_eligibility
  end

  def perform(claim_id, data)
    data.each do |flight_collected_data|
      flight = @flight_repository.find_by_flight_identifier!(flight_collected_data['flight_identifier'])
      flight_attrs = {
        flight_status: flight_collected_data['flight_status'],
        delay_mins: flight_collected_data['delay_mins']
      }
      @flight_repository.update!(flight, flight_attrs)
    end
    @check_claim_eligibility.call(claim_id)
  end
end
