Rails.application.routes.draw do
  if Rails.env.development?
    get '/login_as/:user_id', to: 'development/sessions#login_as'
  end
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  get '/:id/share_twitter' => 'share#twitter', as: :share_twitter
  get '/term' => 'home#term'
  resources :rankings, only: %i[index]
  resources :users, only: %i[show]
  root to: 'home#index'
end
