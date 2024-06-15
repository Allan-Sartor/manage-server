class Transaction < ApplicationRecord
  belongs_to :business_unit

  validates :amount, presence: true, numericality: true
  validates :description, presence: true
  validates :transaction_type, presence: true
  validates :payment_type, presence: true
end
