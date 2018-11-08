class Period < ActiveHash::Base
  self.data = [
    { id: 1, name: :week, days: 7 },
    { id: 2, name: :month, days: 30 },
    { id: 3, name: :quarter, days: 90 },
    { id: 4, name: :year, days: 365 }
  ]

  class << self
    def days(name)
      name ||= :month
      find_by(name: name).days
    end
  end
end
