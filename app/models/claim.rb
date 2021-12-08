class Claim < ApplicationRecord
  has_many :iterinaries, dependent: :destroy
  has_many :flights, through: :iterinaries
end
