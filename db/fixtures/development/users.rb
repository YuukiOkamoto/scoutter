(1..100).each do |i|
  User.seed(:id) do |s|
    s.id = i
    s.name = 'user' + i.to_s
    s.twitter_id = i
  end
end
