class PowerLevel < ApplicationRecord
  belongs_to :user

  validates :power, presence: true

  scope :weekly, -> { where(updated_at: (Date.today.ago(6.days))..(Time.current)) }
  scope :daily, -> { where(updated_at: (Date.today)..(Time.current)) }

  class << self
    def get_total_power(user_id)
      all.where(user_id: user_id).sum(:power)
    end
  end
end
