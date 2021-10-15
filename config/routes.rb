Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :jobs, only: [:show, :new, :create] do
    get 'my_jobs', on: :collection
  end
end
