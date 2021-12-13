module Services
  module V1
    class CheckClaimEligibility
      MIN_DELAY = 180.freeze
      ELIGIBLE_FLIGHT_STATUS = 'cancelled'.freeze

      def initialize(claim_repository: ::ClaimRepository.new, update_claim: UpdateClaim.new)
        @claim_repository = claim_repository
        @update_claim = update_claim
      end

      def call(claim_id)
        claim = @claim_repository.get_claim_with_flights(claim_id)
        attr = { state: eligible?(claim.flights) ? 'eligible' : 'rejected' }
        @update_claim.call(claim_id, attr)
      end

      private

      def eligible?(flights)
        (flights.any? {|f| f.delay_mins&. > MIN_DELAY }) || (flights.any? {|f| f.flight_status == ELIGIBLE_FLIGHT_STATUS })
      end
    end
  end
end
