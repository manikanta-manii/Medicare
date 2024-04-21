Rails.application.routes.draw do
  resources :posts
  devise_for :users , controllers: {registrations: 'users/registrations'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  resources :patients do
    member do
      get 'show_doctor_info'
      post 'book_appointment'
      get 'show_appointment'
    end
  end 
  # Defines the root path route ("/")
  root "home#index"
end
