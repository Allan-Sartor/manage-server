class InventoryItem < ApplicationRecord
  belongs_to :business_unit
  belongs_to :inventory_category
  has_many :transactions

  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :item_type, presence: true
end
