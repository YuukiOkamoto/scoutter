# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

every 1.day, at: '0:00 am' do
  rake 'yesterday_value:update'
end

every 1.day, at: '0 am' do
  rake 'sum_power_ranking:update'
end
