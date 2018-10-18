namespace :yesterday_value do
  desc '前日終了時点でのいいねの総数を、activityテーブルのyesterday_valueに格納し、更新する'
  task update: :environment do
    Activity.all.each do |activity|
      activity.update(yesterday_value: activity.latest_value)
    end
  end
end
