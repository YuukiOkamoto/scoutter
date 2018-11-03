class SumPower < ApplicationRecord
  belongs_to :user

  enum period: {
    day: 0,
    week: 10,
    total: 99
  }

  validates :period, presence: true

  class << self
    def bulk_create_or_update
      daily_record = day.first_or_initialize
      weekly_record = week.first_or_initialize
      total_record = total.first_or_initialize

      user = daily_record.user

      daily_power = user.daily_power
      weekly_power = user.weekly_power
      total_power = user.total_power


      daily_record.update_attributes(power: daily_power) if daily_record.power != daily_power
      weekly_record.update_attributes(power: weekly_power) if weekly_record.power != weekly_power
      total_record.update_attributes(power: total_power) if total_record.power != total_power
    end
  end
end
