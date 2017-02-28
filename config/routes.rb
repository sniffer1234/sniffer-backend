Rails.application.routes.draw do

  get '/' => 'landing_page/home#index'
  get '/termos-de-uso' => 'landing_page/terms#index'

  # Api
  # Necessary to use devise_scope to avoid route conflicts
  devise_scope :user do
    match "/api/sign_in" => 'api/sessions#create', via: :post
    match "/api/sign_up" => 'api/registrations#create', via: :post
    match "/api/password" => 'api/passwords#create', via: :post
    match "/api/password" => 'api/passwords#update', via: :put
    match "/api/confirmation" => 'api/confirmations#show', via: :get
  end

  namespace :api, defaults: { format: 'json' } do
    resources :events, only: [:index, :show]
    resources :sniffs, only: [:index]

    resources :establishments, only: [:index, :show, :create] do
      member { get :events }
      collection { get :sniffs }
      resources :sniffs, only: [:index]
      resources :chat, only: [:index] do
        resources :chat_messages, only: [:create]
      end
    end
    resources :live, only: [:index]
    resources :sniffs, only: [:index]
    resources :tags, only: [:index]
    resources :zipcode, only: [:index]
    resources :facebook, only: [:create]
    match '/me' => 'me#update', via: :put
    match '/me/password' => 'me#update_password', via: :put
    match '/me/sniff' => 'me#create_sniff', via: :post
    match '/me/sniffs' => 'me#sniffs', via: :get
  end

  # Admin
  devise_for :users, path: '/admin'
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
