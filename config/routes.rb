Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  mount Sidekiq::Web => '/sidekiq' # Montar a interface do Sidekiq

  resources :users, only: [:show, :update]
  resources :plans, only: [:index, :show]
  resources :business_units
  resources :clients
  resources :transactions
  resources :inventory_items
  resources :payments, only: [:create]
end
