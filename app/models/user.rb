class User < ApplicationRecord
  authenticates_with_sorcery!
  has_one_attached :icon

  has_many :power_levels
  has_many :authentications, dependent: :destroy

  belongs_to :character

  validates :name, presence: true
  validates :twitter_id, presence: true
end
