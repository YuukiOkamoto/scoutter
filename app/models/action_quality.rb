class ActionQuality < ApplicationRecord
  belongs_to :action

  has_one :action_point

  enum quality: { bad: 5, nomal: 10, good: 15, very_good: 20 }

  validates :minimum, presence: true
  validates :maximum, presence: true
  validates :quality, presence: true
end
