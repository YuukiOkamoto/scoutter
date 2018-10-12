Rails.application.routes.draw do
  root to: 'home#index'
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  resources :users, only: %i[show]
  get '/users/:id/screenshot' => 'users#take_screenshot', as: :share_twitter
end
