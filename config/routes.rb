# Configuração das rotas.
#
# As rotas definidas com o formato padrão JSON.
# As rotas utilizam o Devise Token Auth para autenticação do usuário e incluem rotas para gerenciar contatos.

require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    # Monta as rotas do Devise Token Auth para o modelo User no caminho "/api/auth"
    mount_devise_token_auth_for 'User', at: 'auth'
    # mount Sidekiq::Web => '/sidekiq' # Montar a interface do Sidekiq

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show, :update]
      resources :plans, only: [:index, :show]
      resources :business_units
      resources :clients
      resources :transactions
      resources :inventory_items
      resources :payments, only: [:create]
    end
  end
end
