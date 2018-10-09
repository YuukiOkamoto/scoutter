Rails.application.routes.draw do
  get '/ranking', to: 'power_levels#rank'
  root to: 'home#index'
end
