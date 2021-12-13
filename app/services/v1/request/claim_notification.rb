require 'typhoeus'

module Services
  module V1
    module Request
      class ClaimNotification
        NOTIFICATION_PATH = "https://6194b16e9b1e780017ca2105.mockapi.io/api/v1/claim_notifications".freeze
        REQUESTER = "yzmopolis".freeze

        def call(claim_id)
          request = Typhoeus::Request.new(
            NOTIFICATION_PATH,
            method: :post,
            body: body(claim_id),
            headers: headers,
            followlocation: true
          )
        request.run
        end

        private

        def body(claim_id)
          {
            claim_id: claim_id,
            requester: REQUESTER
          }.to_json
        end

        def headers
          {
            "Content-Type" => "application/json"
          }
        end
      end
    end
  end
end
