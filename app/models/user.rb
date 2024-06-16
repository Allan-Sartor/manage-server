# frozen_string_literal: true

class User < ApplicationRecord
  # Módulos do Devise para autenticação
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Devise Token Auth para autenticação baseada em token
  include DeviseTokenAuth::Concerns::User

  # Associações
  has_one :business_unit, dependent: :destroy

  # Callbacks
  # Define a data de expiração do teste gratuito após a criação do usuário
  after_create :set_trial_period

  def set_trial_period
    update(trial_end_date: 7.days.from_now)
  end

  def active?
    business_unit.present? && business_unit.active?
  end
end
