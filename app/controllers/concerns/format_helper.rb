# Módulo: FormatHelper
#
# O módulo `FormatHelper` fornece funções auxiliares para formatação de mensagens e serialização de objetos em formato JSON.
# Este módulo é protegido e deve ser incluído em classes que necessitam dessas funcionalidades.

module FormatHelper
  protected

  # Método: serializer_as_json
  #
  # Este método serializa um objeto utilizando o ActiveModelSerializers e o retorna no formato JSON.
  #
  # Params:
  # - render: O objeto que será serializado.
  #
  # Returns:
  # - JSON: O objeto serializado em formato JSON.
  def serializer_as_json(render)
    ActiveModelSerializers::SerializableResource.new(render).as_json
  end

  # Método: render_message_i18n
  #
  # Este método traduz uma mensagem de acordo com as configurações de internacionalização (I18n).
  #
  # Params:
  # - message: A chave da mensagem que será traduzida.
  #
  # Returns:
  # - String: A mensagem traduzida.
  def render_message_i18n(message)
    I18n.t(message)
  end

  # Método: render_error_message
  #
  # Este método renderiza uma mensagem de erro no formato JSON.
  #
  # Params:
  # - data: O objeto que contém os erros, se houver.
  # - message: A chave da mensagem de erro que será traduzida.
  # - status: O código de status HTTP que será retornado na resposta.
  #
  # Returns:
  # - JSON: Um objeto JSON contendo a mensagem de erro traduzida e, se presentes, os erros do objeto.
  def render_error_message(data, message, status)
    response = {
      message: render_message_i18n(message),
      errors: data.errors
    }.compact

    render json: response, status: status
  end
end
