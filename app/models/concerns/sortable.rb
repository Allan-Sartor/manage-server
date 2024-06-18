# frozen_string_literal: true

# Module Sortable
#
# Este módulo fornece funcionalidades para ordenar registros.
# Ele inclui métodos para ordenação ascendente e descendente, permitindo que os registros sejam classificados
# com base em uma coluna específica e uma direção de ordenação.
module Sortable
  extend ActiveSupport::Concern

  # Direções de ordenação suportadas
  DIRECTIONS = ['asc', 'desc'].freeze

  class_methods do
    # Método para ordenar os registros do modelo
    #
    # Params:
    # - sort: A coluna pela qual os registros devem ser ordenados
    # - dir: A direção da ordenação (ascendente ou descendente)
    #
    # Returns:
    # Uma coleção de registros ordenados de acordo com os parâmetros fornecidos
    def sorted(sort, dir)
      if respond_to?(:sort_by, true)
        column = column(sort)
        direction = direction(dir)
        order("#{column} #{direction}")
      else
        all
      end
    end

    private

    # Método para determinar a coluna de ordenação com base na coluna solicitada
    #
    # Params:
    # - sort: A coluna pela qual os registros devem ser ordenados
    #
    # Returns:
    # A coluna de ordenação a ser utilizada
    def column(sort)
      sort_by.include?(sort) ? sort : sort_by[0]
    end

    # Método para determinar a direção de ordenação com base na direção solicitada
    #
    # Params:
    # - dir: A direção da ordenação (ascendente ou descendente)
    #
    # Returns:
    # A direção de ordenação a ser utilizada
    def direction(dir)
      DIRECTIONS.include?(dir) ? dir : DIRECTIONS[0]
    end
  end
end
