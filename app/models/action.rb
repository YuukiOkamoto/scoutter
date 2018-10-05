class Action < ApplicationRecord
  has_many :action_qualities
  has_many :action_points, through: :action_qualities

  validates :name, presence: true
  validates :twitter_id, presence: true
end
