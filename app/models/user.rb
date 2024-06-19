# frozen_string_literal: true

class User < ApplicationRecord
  # Módulos do Devise para autenticação
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Devise Token Auth para autenticação baseada em token
  include DeviseTokenAuth::Concerns::User

  # Associações
  has_many :business_units, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy

  def can_create_business_unit?
    return true if business_units.empty?

    current_plan = business_units.first&.plan
    return false unless current_plan

    business_units.count < current_plan.max_business_units
  end

  # Método para verificar se o usuário pode acessar funcionalidades avançadas
  def has_advanced_features?
    ['Médio', 'Médio', 'Anual', 'Premium', 'Premium', 'Anual'].include?(plan.name)
  end

  def active?
    business_unit.present? && business_unit.active?
  end
end
