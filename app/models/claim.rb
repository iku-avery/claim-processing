class Claim < ApplicationRecord
  has_many :iterinaries, dependent: :destroy
  has_many :flights, through: :iterinaries

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  enum state: { in_progress: 0, rejected: 1, eligible: 2 }, _default: :in_progress
end
