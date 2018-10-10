(1..100).each do |i|
  User.seed(:id) do |s|
    s.id = i
    s.name = 'user' + i.to_s
    s.twitter_id = i
    s.total_power = PowerLevel.get_total_power(user_id: i)
    s.character_id = Character.character_decision(
      PowerLevel.where(user_id: i).sum(:power)
    )
  end
end
