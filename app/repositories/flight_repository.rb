class FlightRepository
  def find_or_create(flight_identifier, attributes)
    Flight.where(flight_identifier: flight_identifier).first_or_create do |flight|
      flight.airline_code = attributes[:airlineCode]
      flight.flight_number = attributes[:flightNumber]
      flight.departure_date = attributes[:departureDate]
      flight.departure_airport_code = attributes[:departureAirportCode]
      flight.arrival_airport_code = attributes[:arrivalAirportCode]
    end
  end
end
