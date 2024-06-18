# frozen_string_literal: true

class InventoryCategory < ApplicationRecord
  belongs_to :business_unit
  has_many :inventory_items, dependent: :destroy

  validates :name, presence: true
end
