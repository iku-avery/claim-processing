class Flight < ApplicationRecord
  has_many :iterinaries, dependent: :destroy
  has_many :claims, through: :iterinaries
end
