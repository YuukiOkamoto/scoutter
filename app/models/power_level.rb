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
  end
end
