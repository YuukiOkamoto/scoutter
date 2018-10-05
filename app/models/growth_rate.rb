class GrowthRate < ApplicationRecord
  validates :minimum, presence: true
  validates :maximum, presence: true
  validates :growth_rate, presence: true
end
