set :output, '/usr/src/app/log/crontab.log'
ENV.each { |k, v| env(k, v) }

every 1.day, at: '0:00 am' do
  rake 'yesterday_value:update'
end

every 1.day, at: '0 am' do
  rake 'sum_power_ranking:update'
end
