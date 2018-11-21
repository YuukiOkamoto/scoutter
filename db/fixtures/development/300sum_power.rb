User.all.each.with_index(1) do |u, i|
  SumPower.seed(:id) do |s|
    s.id = i
    s.user_id = u.id
    s.power = u.daily_power
    s.period = 0
  end
end

User.all.each.with_index(101) do |u, i|
  SumPower.seed(:id) do |s|
    s.id = i
    s.user_id = u.id
    s.power = u.weekly_power
    s.period = 10
  end
end

User.all.each.with_index(201) do |u, i|
  SumPower.seed(:id) do |s|
    s.id = i
    s.user_id = u.id
    s.power = u.total_power
    s.period = 99
  end
end
