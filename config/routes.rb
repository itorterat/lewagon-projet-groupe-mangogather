Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'dashboard', to: 'pages#dashboard'
  resources :users, only: %i[index show]
  resources :bookings, only: %i[index new create show]
  get 'search', to: 'pages#search'
end
