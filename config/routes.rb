Rails.application.routes.draw do
  get "sessions/new"

  root "static_pages#home"

  get "static_pages/about"
  get "/signup", to: "users#new"
  get "/home", to: "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: [:create, :new, :show]

end
