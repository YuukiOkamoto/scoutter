(1..10000).each do |i|
  PowerLevel.seed(:id) do |s|
    s.id = i
    s.user_id = i % 100 + 1
    s.power = i * (i % 100 + 1)
  end
end
