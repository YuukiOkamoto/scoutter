class PowerLevel < ApplicationRecord
  belongs_to :user

  validates :power, presence: true

  scope :weekly, -> { where(updated_at: (Date.today.ago(6.days))..(Time.current)) }
  scope :daily, -> { where(updated_at: (Date.today)..(Time.current)) }
  # 指定日（count日前）以前すべて
  scope :until_ago, ->(count) { where('updated_at<=?', Time.zone.today.ago(count.days).end_of_day) }
  # 指定日(count日前)
  scope :ago, ->(count) do
    where(updated_at: Time.zone.today.ago(count.days).beginning_of_day..Time.zone.today.ago(count.days).end_of_day)
  end

  class << self
    # period日前からの日次の戦闘力合計を配列で返す
    def get_per_day_array(period)
      start_power = all.until_ago(period).sum(:power)
      period.step(1, -1).map { |i| start_power += all.ago(i - 1).sum(:power) }
    end
  end
end
