Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users, only: %i[index show] do
    resources :bookings, only: %i[new create] do
      resources :reviews, only: %i[new create show]
    end
  end
  get 'profile', to: 'users#edit_profile', as: :edit_profile
  patch 'profile', to: 'users#update_profile', as: :update_profile

  resources :bookings, only: %i[index show] do
    member do
      patch :accept
      patch :decline
    end
  end

  resources :conversations, only: %i[index create] do
    resources :messages, only: %i[index new create]
  end

  get 'search', to: 'pages#search'
  get 'dashboard', to: 'pages#dashboard'
end
