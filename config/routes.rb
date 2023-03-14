Rails.application.routes.draw do
  resources :posts
  resources :authors, only: [:index, :show, :create]
end