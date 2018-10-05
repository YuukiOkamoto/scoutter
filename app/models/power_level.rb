class PowerLevel < ApplicationRecord
  belongs_to :user

  validates :power, presence: true
end
