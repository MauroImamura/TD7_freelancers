Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :jobs, only: [:show, :new, :create]
end
