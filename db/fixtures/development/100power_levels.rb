(1..10000).each do |i|
  PowerLevel.seed(:id) do |s|
    s.id = i
    s.user_id = i % 100 + 1
    s.power = ((i * (i % 100 + 1)) / Rational(1000000, ((i % 100 + 1)**6))).to_i
    s.updated_at = Time.current.ago(i**2)
  end
end
