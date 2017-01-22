Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    resources :events, only: [:index, :show]
    resources :establishments, only: [:index, :show]
    resources :live, only: [:index]
    resources :sniffs, only: [:index]
  end

  mount_devise_token_auth_for 'User', at: 'api/auth'
end
