class CreateFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :flights, id: :uuid do |t|
      t.string :flight_identifier
      t.string :airline_code
      t.string :flight_number
      t.string :departure_date
      t.string :departure_airport_code
      t.string :arrival_airport_code
      t.integer :delay_mins
      t.integer :flight_status

      t.timestamps
    end
  end
end
