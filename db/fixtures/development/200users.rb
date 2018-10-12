(1..100).each do |i|
  User.seed(:id) do |s|
    s.id = i
    s.name = 'user' + i.to_s
    s.twitter_id = i
    s.character_id = Character.decide_character_id(
      PowerLevel.where(user_id: i).sum(:power)
    )
  end
end
