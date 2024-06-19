# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :business_unit
  belongs_to :client, optional: true
  belongs_to :inventory_item, optional: true

  # Tipos válidos de transações
  TRANSACTION_TYPES = ['income', 'expense', 'dividends', 'inventory_adjustment', 'product_sale'].freeze

  # Escopos válidos de transações
  TRANSACTION_SCOPES = ['compra', 'venda', 'despesa', 'receita', 'dividends', 'inventory_adjustment'].freeze

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :transaction_type, presence: true, inclusion: { in: TRANSACTION_TYPES }
  validates :payment_type, presence: true
  validates :transaction_scope, presence: true, inclusion: { in: TRANSACTION_SCOPES }
  validates :status, presence: true, inclusion: { in: ['pending', 'paid'] }
  validate :dividends_must_have_client

  # Escopos
  scope :income, -> { where(transaction_type: 'income') }
  scope :expense, -> { where(transaction_type: 'expense') }
  scope :compra, -> { where(transaction_scope: 'compra') }
  scope :venda, -> { where(transaction_scope: 'venda') }
  scope :despesa, -> { where(transaction_scope: 'despesa') }
  scope :receita, -> { where(transaction_scope: 'receita') }
  scope :dividends, -> { where(transaction_scope: 'dividends') }

  # Callback para ajustar o inventário após criar uma transação
  after_create :adjust_inventory, if: -> { inventory_item.present? }

  private

  def adjust_inventory
    case transaction_scope
    when 'venda'
      if inventory_item.quantity >= amount
        inventory_item.update(quantity: inventory_item.quantity - amount)
      else
        errors.add(:base, 'Insufficient inventory for the selected item.')
        raise ActiveRecord::Rollback
      end
    when 'compra', 'inventory_adjustment'
      inventory_item.update(quantity: inventory_item.quantity + amount)
    end
  end

  def dividends_must_have_client
    return unless transaction_scope == 'dividends' && client.nil?

    errors.add(:client, 'must be present for dividends transactions')
  end
end
