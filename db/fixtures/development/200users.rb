(1..100).each do |i|
  User.seed(:id) do |s|
    s.id = i
    s.name = 'user' + i.to_s
    s.twitter_id = i
    s.character_id = Character.decide_character_id(
      PowerLevel.where(user_id: i).sum(:power)
    )
    if i % 3 == 0
      s.image = "https://pbs.twimg.com/profile_images/1019140819754741760/62O16-u-.jpg"
    elsif i % 7 == 0
      s.image = "https://abs.twimg.com/sticky/default_profile_images/default_profile.png"
    elsif i % 20 == 0
      s.image = "https://pbs.twimg.com/profile_images/1030013851058679808/C5xBgScL.jpg"
    else
      s.image = "https://pbs.twimg.com/profile_images/1051707879269363712/82Rqsma8.jpg"
    end
  end
end
