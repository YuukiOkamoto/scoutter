class Period < ActiveHash::Base
  self.data = [
    { id: 1, name: :Day },
    { id: 2, name: :Week },
    { id: 3, name: :Total }
  ]
end
