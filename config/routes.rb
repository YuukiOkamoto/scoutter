Rails.application.routes.draw do
  get 'power_levels', to: 'users#show'
  get '/ranking', to: 'users#rank'
  root to: 'home#index'
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
end
