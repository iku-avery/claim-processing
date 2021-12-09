class Flight < ApplicationRecord
  has_many :iterinaries, dependent: :destroy
  has_many :claims, through: :iterinaries

  validates :airline_code, presence: true
  validates :flight_number, presence: true
  validates :departure_date, presence: true
  validates :departure_airport_code, presence: true
  validates :arrival_airport_code, presence: true

  enum status: { no_data: 0, delayed: 1, on_time: 2, cancelled: 3 }, _default: :no_data
end
