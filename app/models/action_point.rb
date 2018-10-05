class ActionPoint < ApplicationRecord
  belongs_to :action_quality

  validates :point, presence: true
end
