class Character < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :introduction, presence: true
  validates :minimum, presence: true
  validates :maximum, presence: true
  validates :growth_rate, presence: true

  scope :power_range, -> { select(:id, :minimum, :maximum) }

  class << self
    def decide_character_id(total_power)
      all.find_by('minimum <= ? && ? <=  maximum', total_power, total_power)&.id
    end
  end
end
