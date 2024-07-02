Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'



  resources :tasks do
    collection do
      post 'create_task'
      get 'delete_task'
      post 'create_user'
    end
    member do
      post 'update_task' 
      post 'delete_task'     
    end
  end

  resources :dashboard do
    collection do
      get 'index'
    end
  end

end
