require 'typhoeus'

module Services
  module V1
    module Request
      class BulkCollectFlightData
        FLIGHTS_PATH = "https://6194b16e9b1e780017ca2105.mockapi.io/api/v1/flights?".freeze
        def call(flights_idenfifiers)
          hydra = Typhoeus::Hydra.new
          requests = flights_idenfifiers.map{ |flight_identifier|
            request = Typhoeus::Request.new(
              "#{FLIGHTS_PATH}flight_identifier=#{flight_identifier}",
              method: :get,
              headers: headers,
              followlocation: true
            )
            hydra.queue(request)
            request
          }
          hydra.run
          responses = requests.map { |request| JSON(request.response.body) if request.response.code == 200 }.flatten
          responses
        end

        private


          def headers
            {
              "Content-Type" => "application/json"
            }
          end
      end
    end
  end
end
