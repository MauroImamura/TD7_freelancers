Rails.application.routes.draw do
  devise_for :workers
  devise_for :users
  root to: 'home#index'
  resources :jobs, only: [:show, :new, :create] do
    get 'my_jobs', on: :collection
    get 'accepted_jobs', on: :collection
    post 'finish_hiring', on: :member
    post 'finish_project', on: :member
    resources :applications, only: [:show, :create], shallow: true do
      resources :worker_feedbacks, only: [:show, :create, :new]
      post 'accept', on: :member
      post 'refuse', on: :member
    end
  end
  get 'my_profile', to: 'workers#my_profile'
  get 'job_list', to: 'jobs#jobs_list'
end
