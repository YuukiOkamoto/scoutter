set :output, '/usr/src/app/log/crontab.log'

every 1.day, at: '0:00 am' do
  rake 'yesterday_value:update'
end

every 1.day, at: '0 am' do
  rake 'sum_power_ranking:update'
end
