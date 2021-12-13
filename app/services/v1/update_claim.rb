module Services
  module V1
    class UpdateClaim
      def initialize(claim_repository: ::ClaimRepository.new)
        @claim_repository = claim_repository
      end

      def call(claim_id, claim_attributes)
        claim = @claim_repository.find_by_id(claim_id)
        @claim_repository.update!(claim, claim_attributes)
      end
    end
  end
end
