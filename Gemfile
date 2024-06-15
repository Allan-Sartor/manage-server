source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8", ">= 7.0.8.4"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

gem 'kaminari' # Paginação para ActiveRecord, Mongoid e DataMapper.
gem 'active_model_serializers' # Serialização de objetos ActiveModel.
gem 'rack-attack' # Middleware para proteção contra ataques de força bruta.
gem 'i18n' # Suporte a internacionalização.
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
gem 'dotenv-rails' # Carrega variáveis de ambiente de um arquivo .env.

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

gem 'json', '~> 2.5'
gem 'faraday', '~> 1.0'

gem 'devise'
gem 'devise_token_auth'
gem 'mercadopago'
gem 'sidekiq'
gem 'sidekiq-scheduler'

group :development, :test do
  gem "byebug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails", "~> 6.4" # Biblioteca para criação de dados de teste.
  gem "faker", "~> 3.3", require: false # Geração de dados fictícios.
end

group :development do
  gem 'bullet' # Detecta consultas N+1 e código ineficiente.
  gem 'letter_opener' # Visualiza e-mails no navegador durante o desenvolvimento.
  gem 'solargraph', require: false # Servidor de linguagem Ruby para IDEs.
  gem 'rubocop', "~> 1.53.0" # Ferramenta de análise estática de código.
  gem 'rubocop-performance', require: false # Extensão do RuboCop focada em performance.
  gem 'rubocop-rails', require: false # Extensão do RuboCop para projetos Rails.
  gem 'rubocop-rake', require: false # Extensão do RuboCop para Rake.
end

group :test do
  gem "simplecov", "~> 0.22.0" # Gera relatórios de cobertura de código.
  gem "simplecov_json_formatter", "~> 0.1.4" # Formata relatórios do SimpleCov em JSON.
  gem "shoulda-matchers", "~> 5.3" # Matchers para testes de modelos e controladores.
  gem 'rubocop-rspec', '~> 2.6.0', require: false # Extensão do RuboCop para projetos RSpec.
  gem "rspec-rails", "~> 6.1" # Framework de teste para Rails.
end

