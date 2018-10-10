class Character < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :introduction, presence: true
  validates :minimum, presence: true
  validates :maximum, presence: true
  validates :growth_rate, presence: true
end
