class PowerLevel < ApplicationRecord
  belongs_to :user

  validates :power, presence: true

  scope :weekly, -> { where(updated_at: (Date.today.ago(6.days))..(Time.current)) }
  scope :daily, -> { where(updated_at: (Date.today)..(Time.current)) }
  scope :until_ago, ->(count) { where('updated_at<=?', Time.zone.today.ago(count.days).end_of_day) }
  scope :ago, ->(count) do
    where(updated_at: Time.zone.today.ago(count.days).beginning_of_day..Time.zone.today.ago(count.days).end_of_day)
  end

  class << self
    def get_total_power(user_id:)
      all.where(user_id: user_id).sum(:power)
    end

    # 特定ユーザーのcount日前からの日々の戦闘力の合計値を配列で返す
    def get_target_period_array(count, user_id)
      start_power = PowerLevel.until_ago(count).get_total_power(user_id: user_id)
      count.step(1, -1).map { |i| start_power += PowerLevel.ago(i - 1).get_total_power(user_id: user_id) }
    end
  end
end
