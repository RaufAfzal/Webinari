Rails.application.routes.draw do
  # devise_for :views
  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions',
    passwords: 'admin_users/passwords'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcomes#index"

  resources :workshops, only: [:index, :show]
  resources :bookings, only: [:create] do
    get :booking_details, on: :member
  end

  resources :refunds do
    get :refund_acceptance, on: :member
  end

  namespace :admin do
    get 'dashboard' => 'dashboard#index'
    resources :workshops
    resources :bookings
    resources :customers
    resources :refunds
  end
end
