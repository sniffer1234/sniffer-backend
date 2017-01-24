Rails.application.routes.draw do

  root :to => redirect('admin/dashboard')

  # Api routes
  namespace :api, defaults: { format: 'json' } do
    resources :events, only: [:index, :show]
    resources :establishments, only: [:index]
    resources :live, only: [:index]
    resources :sniffs, only: [:index]
    resources :tags, only: [:index]
  end

  #mount_devise_token_auth_for 'User', at: 'api/auth'

  # Admin routes
  scope '/admin' do
    devise_for :users, path: 'auth'
  end

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :establishments, only: [:index, :create, :destroy, :edit, :update]
    resources :users, only: [:index, :create, :destroy, :edit, :update]
    resources :sniffs, only: [:index, :destroy]
  end
end
