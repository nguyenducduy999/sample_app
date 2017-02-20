Rails.application.routes.draw do
  root "static_pages#home"
  get "static_pages/help"
  get "static_pages/about"
  get "/signup", to: "users#new"
  get "/home", to: "static_pages#home"
  resources :users, only: [:create, :new, :show]

end
