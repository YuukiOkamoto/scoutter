class User < ApplicationRecord
  authenticates_with_sorcery!
  has_one_attached :icon

  has_many :sum_power

  has_many :power_levels
  has_many :authentications, dependent: :destroy
  has_many :activities, dependent: :destroy

  belongs_to :character

  delegate :name, :introduction, to: :character, prefix: true

  validates :name, presence: true
  validates :twitter_id, presence: true

  scope :power_rank, -> do
    joins(:sum_power)
      .includes(:character, :sum_power)
      .order('sum_powers.power desc, users.id desc')
  end
  scope :total_period, -> { merge(SumPower.total) }
  scope :week_period, -> { merge(SumPower.week) }
  scope :day_period, -> { merge(SumPower.day) }

  def today_increase_power
    power_levels.daily&.first&.power || 0
  end

  def up_to_next_character
    character.maximum + 1 - power_levels.sum(:power)
  end
end
