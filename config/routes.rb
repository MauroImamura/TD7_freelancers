Rails.application.routes.draw do
  devise_for :workers
  devise_for :users
  root to: 'home#index'
  resources :jobs, only: [:show, :new, :create] do
    get 'my_jobs', on: :collection
    resources :applications, only: [:show, :create], shallow: true
  end
  get 'my_profile', to: 'workers#my_profile'
  get 'job_list', to: 'jobs#jobs_list'
end
