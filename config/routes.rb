Rails.application.routes.draw do
  devise_for :workers
  devise_for :users
  root to: 'home#index'
  resources :workers, only: [:show, :update, :edit] do
    get 'worker_feedback_list', on: :member
    resources :favorited_workers, only: [] do
      post 'add', on: :member
    end
  end
  resources :jobs, only: [:show, :new, :create] do
    get 'my_jobs', on: :collection
    get 'accepted_jobs', on: :collection
    post 'finish_hiring', on: :member
    post 'finish_project', on: :member
    resources :user_feedbacks, only: [:show, :create, :new], shallow: true
    resources :applications, only: [:show, :create, :destroy], shallow: true do
      resources :worker_feedbacks, only: [:show, :create, :new]
      post 'accept', on: :member
      post 'refuse', on: :member
    end
  end
  get 'my_profile', to: 'workers#my_profile'
  get 'job_list', to: 'jobs#jobs_list'
  get 'worker_list', to: 'workers#workers_list'
  get 'complete_profile', to: 'workers#complete_profile'
  get 'search', to:"jobs#search"
end
