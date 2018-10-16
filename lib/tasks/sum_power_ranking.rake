namespace :sum_power_ranking do
  desc '日付が変わった時点で日・週・累計の戦闘力合計を集計する'
  task update: :environment do
    users = User.all
    users.each do |user|
      begin
        SumPower.personal_bulk_update(user)
      rescue => e
        logger.debug(e)
        next
      end
    end
  end
end
