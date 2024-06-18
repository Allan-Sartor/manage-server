# frozen_string_literal: true

class User < ApplicationRecord
  # Módulos do Devise para autenticação
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Devise Token Auth para autenticação baseada em token
  include DeviseTokenAuth::Concerns::User

  # Associações
  has_many :business_units, dependent: :destroy

  def can_create_business_unit?
    business_units.count < plan.max_business_units
  end

  # Método para verificar se o usuário pode acessar funcionalidades avançadas
  def has_advanced_features?
    %w[Médio Médio Anual Premium Premium Anual].include?(plan.name)
  end

  def active?
    business_unit.present? && business_unit.active?
  end
end
