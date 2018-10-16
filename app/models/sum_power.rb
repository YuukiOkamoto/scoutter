class SumPower < ApplicationRecord
  belongs_to :user

  enum period: {
    day: 0,
    week: 10,
    total: 99
  }

  validates :period, presence: true

  class << self
    def personal_bulk_update(user)
      daily = PowerLevel.daily.get_total_power(user_id: user.id)
      weekly = PowerLevel.weekly.get_total_power(user_id: user.id)
      total = PowerLevel.get_total_power(user_id: user.id)

      user.sum_power.day.update(power: daily)
      user.sum_power.week.update(power: weekly)
      user.sum_power.total.update(power: total)
    end
  end
end
