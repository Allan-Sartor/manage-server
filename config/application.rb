require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ManageServer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configura o Sidekiq como o adaptador de fila de jobs
    config.active_job.queue_adapter = :sidekiq

    # cofiguração session store
    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options

    # Adiciona arquivos de tradução personalizados
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]

    # Define os locais disponíveis
    I18n.available_locales = [:"en-US", :"pt-BR"]

    # Define o locale padrão
    I18n.default_locale = :"pt-BR"

    # Devise
    config.action_mailer.default_url_options = { host: 'localhost:3001' }

    config.api_only = true
  end
end
