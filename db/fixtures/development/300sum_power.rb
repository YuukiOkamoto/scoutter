User.all.each.with_index(1) do |u, i|
  SumPower.seed(:id) do |s|
    s.id = i
    s.user_id = u.id
    s.power = PowerLevel.daily.get_total_power(user_id: u.id)
    s.period = 0
  end
end

User.all.each.with_index(101) do |u, i|
  SumPower.seed(:id) do |s|
    s.id = i
    s.user_id = u.id
    s.power = PowerLevel.weekly.get_total_power(user_id: u.id)
    s.period = 10
  end
end

User.all.each.with_index(201) do |u, i|
  SumPower.seed(:id) do |s|
    s.id = i
    s.user_id = u.id
    s.power = PowerLevel.get_total_power(user_id: u.id)
    s.period = 99
  end
end
