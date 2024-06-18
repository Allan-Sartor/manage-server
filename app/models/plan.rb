# frozen_string_literal: true

class Plan < ApplicationRecord
  # Validações
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :duration, presence: true, inclusion: { in: ['trial', 'monthly', 'annual'] }
  validates :discount, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, if: :annual_plan?
  validates :periodicity, presence: true, inclusion: { in: ['trial', 'monthly', 'annual'] }
  validates :max_business_units, presence: true, numericality: { greater_than_or_equal_to: 1 }
  
  # Associações
  has_many :business_units

  # Método para calcular o preço com desconto
  def discounted_price
    return price unless annual_plan?

    (price * 12) * (1 - (discount / 100))
  end

  private

  def annual_plan?
    periodicity == 'annual'
  end
end
