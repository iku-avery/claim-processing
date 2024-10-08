module Services
  module V1
    class CreateClaim
      Result = Struct.new(:code, :message, :claim_id, keyword_init: true) do
        def response_body
          if response_code.in?(200..299)
            { claim_id: claim_id }
          else
            { message: message }
          end
        end
        def response_code
          code
        end
      end
      def initialize(claim_repository: ::ClaimRepository.new,
                    create_flight: CreateFlight.new,
                    collect_flights_data: ::CollectFlightsDataWorker)
        @claim_repository = claim_repository
        @create_flight = create_flight
        @collect_flights_data = collect_flights_data
      end

      def call(payload)
        claim_result = run_claim_transaction(payload)
        result = if claim_result.success?
          run_worker(claim_result.claim_id)
          Result.new(claim_id: claim_result.claim_id, code: 201)
        else
          Result.new(code: 400, message: claim_result.message)
        end
        result
      end

      private

      def run_worker(claim_id)
        @collect_flights_data.perform_in(1, claim_id)
      end

      def run_claim_transaction(payload)
        ActiveRecord::Base.transaction do
          begin
            claim = @claim_repository.build(
              email: payload.fetch(:email),
              first_name: payload.fetch(:firstName),
              last_name: payload.fetch(:lastName)
            )
            flights_data = payload.fetch(:flights)
            add_flights(claim, flights_data)

            persist!(claim)
            ClaimResult.new(claim_id: claim.id)
          end
        rescue StandardError => e
          ClaimResult.new(message: e)
        end
      end


      def add_flights(claim, flights)
        flights.each do |flight_data|
          flight = @create_flight.call(flight_data)
          claim.flights << flight
        end
      end

      def persist!(claim)
        @claim_repository.save!(claim)
      end
    end
  end
end
