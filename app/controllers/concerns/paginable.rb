# Módulo: Paginable
#
# O módulo fornece funcionalidade para gerenciar a paginação de listagens.
# Ele inclui métodos para obter a página atual, o número de itens por página e para gerar atributos de metadados para uma coleção paginada.
module Paginable
  protected

  # Método para obter a página atual da requisição
  def current_page
    (params[:page] || 1).to_i
  end

  # Método para obter o número de itens por página da requisição
  def per_page
    (params[:per_page] || 20).to_i
  end

  # Método para gerar atributos de metadados para uma coleção paginada
  #
  # Params:
  # - collection: A coleção paginada
  # - extra_meta: Metadados extras a serem incluídos (opcional)
  #
  # Returns:
  # Um hash com os atributos de metadados, incluindo a página atual, o total de itens e o número de itens por página
  def meta_attributes(collection, extra_meta = {})
    {
      current_page: collection.current_page,
      totalItems: collection.total_count,
      itemsPerPage: collection.limit_value
    }.merge(extra_meta)
  end
end
