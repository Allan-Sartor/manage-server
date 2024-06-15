# frozen_string_literal: true

class Plan < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
