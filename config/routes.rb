Rails.application.routes.draw do
  root "static_pages#home"
  post "check_card", to: "static_pages#check_card"
  resources :cards
end
