class Action < ApplicationRecord
  has_many :action_qualities
  has_many :action_points, through: :action_qualities
  has_many :activities, dependent: :destroy

  validates :name, presence: true
  validates :twitter_id, presence: true

  scope :fav, -> { find(1) }
  scope :retweet, -> { find(2) }
  scope :quote, -> { find(3) }
  scope :reply, -> { find(4) }
  scope :xs_tweet, -> { find(5) }
  scope :s_tweet, -> { find(6) }
  scope :l_tweet, -> { find(7) }
  scope :xl_tweet, -> { find(8) }
end
