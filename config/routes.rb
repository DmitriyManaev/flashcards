Rails.application.routes.draw do
  root "static_pages#home"
  match "/", to: "static_pages#home", via: :post
  resources :cards
end
