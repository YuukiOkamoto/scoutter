class PowerLevel < ApplicationRecord
  belongs_to :user

  validates :power, presence: true

  class << self
    def get_total_power(user_id: current_user&.id)
      all.where(user_id: user_id).sum(:power)
    end
  end
end
