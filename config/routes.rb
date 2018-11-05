Rails.application.routes.draw do
  if Rails.env.development?
    get '/login_as/:user_id', to: 'development/sessions#login_as'
  end
  get '/ranking', to: 'users#rank'
  get '/ranking/self', to: 'users#my_rank'
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  resources :users, only: %i[show]
  get '/users/:id/share_twitter' => 'users#share_twitter', as: :share_twitter
  get '/term' => 'home#term'
  root to: 'home#index'
end
