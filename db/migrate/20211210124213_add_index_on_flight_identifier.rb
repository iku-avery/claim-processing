class AddIndexOnFlightIdentifier < ActiveRecord::Migration[6.1]
  def change
    add_index :flights, :flight_identifier, unique: true
  end
end
