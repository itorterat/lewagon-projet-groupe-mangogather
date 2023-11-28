Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :users, only: %i[index show]
  # Defines the root path route ("/")
  # root "articles#index"
end
