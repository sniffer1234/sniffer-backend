Rails.application.routes.draw do

  namespace :admin do
    get 'events/index'
  end

  namespace :admin do
    get 'events/new'
  end

  namespace :admin do
    get 'events/edit'
  end

  root :to => redirect('admin/dashboard')

  # Api routes
  namespace :api, defaults: { format: 'json' } do
    mount_devise_token_auth_for 'User', at: 'auth'

    resources :events, only: [:index, :show]
    resources :establishments, only: [:index]
    resources :live, only: [:index]
    resources :sniffs, only: [:index]
    resources :tags, only: [:index]
    resources :zipcode, only: [:index]
  end

  # Admin routes
  scope '/admin' do
    devise_for :users, path: 'auth'
  end

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :events, only: [:index, :new, :create, :destroy, :edit, :update]
    resources :establishments, only: [:index, :new, :create, :destroy, :edit, :update] do
      resources :events, only: [:create, :edit, :update]
      resources :sniffs, only: [:destroy]
    end
    resources :users, only: [:index, :new, :create, :destroy, :edit, :update]
    resources :sniffs, only: [:index, :destroy]
  end
end
