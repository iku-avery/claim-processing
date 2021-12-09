module Services
  module V1
    class CreateFlight
      def initialize(flight_repository: ::FlightRepository.new)
        @flight_repository = flight_repository
      end

      def call(params)
        flight_identifier = prepare_flight_identifier(params)
        flight = @flight_repository.find_or_create(flight_identifier, params)
        flight
      end

      private

      def prepare_flight_identifier(params)
        airline_code = params[:airlineCode]
        flight_number = params[:flightNumber]
        departure_date = params[:departureDate].tr('-', '')
        departure_airport_code = params[:departureAirportCode]
        arrival_airport_code = params[:arrivalAirportCode]
        flight_identifier = "#{airline_code}-#{flight_number}-#{departure_date}-#{departure_airport_code}-#{arrival_airport_code}"
        flight_identifier
      end
    end
  end
end
