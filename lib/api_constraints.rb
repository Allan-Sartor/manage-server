# Classe: ApiConstraints
#
# A classe `ApiConstraints` é responsável por definir as restrições de versão para a API.
# Utilizada para garantir que as requisições sejam roteadas para a versão correta do módulo com base no cabeçalho da versão da API.

class ApiConstraints
  # Inicializa uma nova instância de ApiConstraints
  #
  # Params:
  # - options: Um hash de opções que inclui:
  #   - :version (Integer) - A versão da API.
  #   - :default (Boolean) - Indica se esta é a versão padrão da API.
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  # Verifica se a requisição corresponde à versão da API.
  #
  # Params:
  # - req: O objeto da requisição HTTP.
  #
  # Returns:
  # - Boolean: Retorna verdadeiro se a requisição corresponde à versão da API ou se é a versão padrão.
  def matches?(req)
    @default || req.headers['Accept']&.include?("application/vnd.server.v#{@version}")
  end
end
