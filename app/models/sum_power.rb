class SumPower < ApplicationRecord
  belongs_to :user

  enum period: {
    day: 0,
    week: 10,
    total: 99
  }

  validates :period, presence: true
end
