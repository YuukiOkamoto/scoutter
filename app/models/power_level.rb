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
    # 特定ユーザーのcount日前からの日々の戦闘力の合計値を配列で返す
    def get_target_period_array(count, user_id)
      user = User.find(user_id)
      start_power = user.power_levels.until_ago(count).sum(:power)
      count.step(1, -1).map { |i| start_power += user.power_levels.ago(i - 1).sum(:power) }
    end
  end
end
