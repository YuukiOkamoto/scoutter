class Character < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true
  validates :minimum, presence: true
  validates :maximum, presence: true
end
