Rails.application.routes.draw do
  get '/ranking', to: 'users#rank'
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  resources :users, only: %i[show]
  root to: 'home#index'
end
