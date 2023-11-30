Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users, only: %i[index show]
  get 'profile', to: 'users#edit_profile', as: :edit_profile
  patch 'profile', to: 'users#update_profile', as: :update_profile

  resources :bookings, only: %i[index new create show]

  get 'search', to: 'pages#search'
end
