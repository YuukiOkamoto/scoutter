namespace :sum_power_ranking do
  desc '日付が変わった時点で日・週・累計の戦闘力合計を集計する'
  task update: :environment do
    users = User.all
    users.each do |user|
      SumPower.bundle_update(user)
    end
  end
end
