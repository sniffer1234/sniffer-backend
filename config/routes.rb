Rails.application.routes.draw do

  root :to => redirect('admin/dashboard')
  # Api routes
  namespace :api, defaults: { format: 'json' } do
    devise_for :users, path: 'auth',
      :controllers => {
        :sessions => 'api/devise/sessions',
        :registrations => 'api/devise/registrations',
        :passwords => 'api/devise/passwords',
        :confirmations => 'api/devise/confirmations',
        :omniauth_callbacks => 'api/devise/omniauth_callbacks'
      }

    resources :events, only: [:index, :show]
    resources :establishments, only: [:index, :show, :create] do
      member { get :events }
    end
    resources :live, only: [:index]
    resources :sniffs, only: [:index]
    resources :tags, only: [:index]
    resources :zipcode, only: [:index]
    match '/me' => 'me#update', via: :put
    match '/me/password' => 'me#update_password', via: :put
  end

  # Admin routes
  # scope '/admin' do
  #   devise_for :users, path: 'auth'
  # end

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :events, only: [:index, :edit, :update, :destroy]
    resources :establishments, only: [:index, :new, :create, :destroy, :edit, :update] do
      resources :establishment_events, only: [:index, :new, :create, :destroy, :edit, :update]
      resources :sniffs, only: [:destroy]
    end
    resources :imgs do
      put :sort, on: :collection
    end

    resources :users, only: [:index, :new, :create, :destroy, :edit, :update]
    resources :sniffs, only: [:index, :destroy]
  end
end
