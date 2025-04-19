Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check


  namespace :api do
    namespace :v1 do
      get 'program_days/:day_number/activities', to: 'program_days#activities'
      patch 'program_day_activities/:id/complete', to: 'program_day_activities#complete'

      resources :activities, only: [:index, :create, :update, :destroy]
      
      get 'program_days', to: 'program_days#index'
    end
   end
  # Defines the root path route ("/")
  # root "posts#index"
end
