# TODO: 動作確認のため実行環境をdevelopmentに指定しているが、本番環境では変更の必要あり
set :environment, :development

every 1.day, at: '0:00 am' do
  rake 'yesterday_value:update'
end

every 1.day, at: '0 am' do
  rake 'sum_power_ranking:update'
end
