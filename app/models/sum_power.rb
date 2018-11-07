class SumPower < ApplicationRecord
  belongs_to :user

  enum period: {
    day: 0,
    week: 10,
    total: 99
  }

  validates :period, presence: true

  class << self
    def where_period(period)
      where(period: periods[period])
    end
    def bulk_create_or_update
      daily_record = day.first_or_initialize
      weekly_record = week.first_or_initialize
      total_record = total.first_or_initialize

      daily_record.power = daily_record.user.daily_power
      weekly_record.power = weekly_record.user.weekly_power
      total_record.power = total_record.user.total_power

      daily_record.save if daily_record.changed?
      weekly_record.save if daily_record.changed?
      total_record.save if daily_record.changed?
    end
  end
end
