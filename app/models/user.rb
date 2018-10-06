class User < ApplicationRecord
  has_one_attached :icon

  has_many :power_levels

  validates :name, presence: true
  validates :twitter_id, presence: true
end
