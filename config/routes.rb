Rails.application.routes.draw do
  devise_for :users , controllers: {registrations: 'users/registrations'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :manage_doctors
  resources :medicines
  resources :doctors do
    member do
      get 'details'
    end
  end
  resources :feedbacks
  resources :appointments do
    member do
      get 'details'
      get 'download'
    end
  end
  resources :patients do
    member do
      post 'slot_display'
    end
  end
  # Defines the root path route ("/")
  root "home#index"
end
