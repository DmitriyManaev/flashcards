Rails.application.routes.draw do
  root "static_pages#home"
  resources :users
  resources :user_sessions
  get "login", to: "user_sessions#new"
  get "logout", to: "user_sessions#destroy"
  get "signup", to: "users#new"
  post "check_card", to: "static_pages#check_card"
  resources :cards
  match "oauth/callback", to: "oauths#callback", via: [:get, :post]
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
end
