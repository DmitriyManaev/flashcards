Rails.application.routes.draw do
  root "static_pages#home"
  post "/", to: "static_pages#home"
  resources :cards
end
