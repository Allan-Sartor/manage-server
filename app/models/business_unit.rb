class BusinessUnit < ApplicationRecord
  belongs_to :user
  has_many :clients, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :inventory_items, dependent: :destroy

  validates :name, presence: true
end
