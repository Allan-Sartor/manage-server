class Rack::Attack
  # Configura o cache store para o Rack::Attack
  # Usa ActiveSupport::Cache::MemoryStore se a variável de ambiente REDIS_URL não estiver definida
  # ou se o ambiente Rails estiver configurado como test.
  cache.store = ActiveSupport::Cache::MemoryStore.new if !ENV['REDIS_URL'] || Rails.env.test?

  # Limita todas as requisições por IP (50 requisições a cada 5 minutos)
  # A chave usada no cache será: "rack::attack:#{Time.now.to_i/:period}:req/ip:#{req.ip}"
  throttle('req/ip', limit: 50, period: 5.minutes) do |req|
    # Define que a limitação será aplicada com base no endereço IP do cliente
    req.ip

    # Nota: Você pode excluir certos caminhos da limitação, como ativos, descomentando a linha abaixo:
    # unless req.path.start_with?('/assets')
  end
end
