class Authentication < ApplicationRecord
  belongs_to :user

  class << self
    def set_uid(provider)
      find_by(provider: provider).uid
    end
  end
end
