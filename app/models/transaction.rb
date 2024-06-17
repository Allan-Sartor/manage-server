# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :business_unit

  # Tipos válidos de transações
  TRANSACTION_TYPES = ['income', 'expense'].freeze

  # Escopos válidos de transações
  TRANSACTION_SCOPES = ['compra', 'venda', 'despesa', 'receita'].freeze

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :transaction_type, presence: true, inclusion: { in: TRANSACTION_TYPES }
  validates :payment_type, presence: true
  validates :transaction_scope, presence: true, inclusion: { in: TRANSACTION_SCOPES }

  # Escopos
  scope :income, -> { where(transaction_type: 'income') }
  scope :expense, -> { where(transaction_type: 'expense') }
  scope :compra, -> { where(transaction_scope: 'compra') }
  scope :venda, -> { where(transaction_scope: 'venda') }
  scope :despesa, -> { where(transaction_scope: 'despesa') }
  scope :receita, -> { where(transaction_scope: 'receita') }
end
