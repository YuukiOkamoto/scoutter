class Character < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :introduction, presence: true
  validates :minimum, presence: true
  validates :maximum, presence: true
  validates :growth_rate, presence: true

  scope :power_range, -> { select(:id, :minimum, :maximum) }

  class << self
    def character_decision(total_power)
      get_ranges.each do |r|
        if total_power.between?(r.minimum, r.maximum)
          return r.id
        end
      end
    end

    def get_ranges
      Character.select(:id, :minimum, :maximum).to_a
    end
  end
end
