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

  def update!(object, attributes)
    object.assign_attributes(attributes)
    save!(object)
  end

  def save!(object)
    object.save!
  end

  def find_by_flight_identifier!(flight_identifier)
    Flight.find_by_flight_identifier!(flight_identifier)
  end
end
