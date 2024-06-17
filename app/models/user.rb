# frozen_string_literal: true

class User < ApplicationRecord
  # Módulos do Devise para autenticação
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Devise Token Auth para autenticação baseada em token
  include DeviseTokenAuth::Concerns::User

  # Associações
  has_one :business_unit, dependent: :destroy

  def active?
    business_unit.present? && business_unit.active?
  end
end
