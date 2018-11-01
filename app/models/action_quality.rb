class ActionQuality < ApplicationRecord
  belongs_to :action

  has_one :action_point

  enum quality: { bad: 5, nomal: 10, good: 15, very_good: 20 }

  validates :minimum, presence: true
  validates :maximum, presence: true
  validates :quality, presence: true

  scope :xs_tweet, -> { find(5) }
  scope :s_tweet, -> { find(6) }
  scope :l_tweet, -> { find(7) }
  scope :xl_tweet, -> { find(8) }
end
