Rails.application.routes.draw do
  devise_for :users , controllers: {registrations: 'users/registrations'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  

  post "slots/display" , to:"doctors#slot_display"

  resources :doctors
  resources :orders
  resources :order_items
  resources :cart_items
  resources :medicines
  resources :feedbacks
  resources :appointments do
    member do
      get 'download'
    end
  end

  # Defines the root path route ("/")
  root "home#index"
end
