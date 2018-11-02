Rails.application.routes.draw do
  if Rails.env.development?
    get '/login_as/:user_id', to: 'development/sessions#login_as'
  end
  get '/ranking', to: 'users#rank'
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  resources :users, only: %i[show]
  get '/users/:id/share_twitter' => 'users#set_share_url', as: :share_twitter
  root to: 'home#index'
  get '/term' => 'home#term'
  get 'errors/twitter_server'
end
