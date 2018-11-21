class Action < ApplicationRecord
  has_many :action_qualities
  has_many :action_points, through: :action_qualities
  has_many :activities, dependent: :destroy

  enum kind: { fav: 1, retweet: 2, quote: 3, reply: 4, tweet: 5 }

  class << self
    def get_quality(kind, quality)
      find_by(kind: kinds[kind]).action_qualities.find_by(quality: ActionQuality.qualities[quality])
    end
  end
end
