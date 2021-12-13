module Services
  module V1
    class GetClaim
      Result = Struct.new(:code, :message, :state, keyword_init: true) do
        def response_body
          if response_code.in?(200..299)
            { state: state }
          else
            { message: message }
          end
        end
        def response_code
          code
        end
      end

      def initialize(claim_repository: ::ClaimRepository.new)
        @claim_repository = claim_repository
      end

      def call(params)
        claim = @claim_repository.find_by_id(params[:id])
        result = if claim
          Result.new(state: claim.state, code: 200)
        else
          Result.new(message: 'Not found', code: 404)
        end
        result
      end
    end
  end
end
