Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  resources :profiles, only: [:index]
  get 'profiles/:username', to: 'profiles#show', as: :profile

  resources :photos, only: [:index, :show, :new, :create, :destroy]

  resources :comments, only: [:create, :edit, :update, :destroy]

  get 'requests', to: 'friend_requests#show', as: :friend_requests
  post 'requests/send', to: 'friend_requests#create', as: :create_friend_request
  post 'requests/accept', to: 'friend_requests#accept', as: :accept_request
  post 'requests/decline', to: 'friend_requests#decline', as: :decline_request

  root 'photos#index'

  get '*path', to: 'photos#index', constraints: lambda { |req| req.path.exclude? 'rails/active_storage' }
end
