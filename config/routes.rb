Rails.application.routes.draw do
  get '/ranking', to: 'power_levels#rank'
  root to: 'home#index'
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
end
