set :environment, :development

every 1.day, at: '0 am' do
  rake 'sum_power_ranking:update'
end
