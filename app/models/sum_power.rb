class SumPower < ApplicationRecord
  belongs_to :user

  enum period: {
    day: 0,
    week: 10,
    total: 99
  }

  validates :period, presence: true

  class << self
    def bundle_update(user_id)
      daily = PowerLevel.daily.get_total_power(user_id: user_id.id)
      weekly = PowerLevel.weekly.get_total_power(user_id: user_id.id)
      total = PowerLevel.get_total_power(user_id: user_id.id)

      user_id.sum_power.day.update(power: daily)
      user_id.sum_power.week.update(power: weekly)
      user_id.sum_power.total.update(power: total)
    end
  end
end
