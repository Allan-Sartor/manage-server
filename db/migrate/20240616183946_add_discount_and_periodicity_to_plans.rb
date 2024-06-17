# frozen_string_literal: true

class AddDiscountAndPeriodicityToPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :discount, :decimal, precision: 5, scale: 2, default: 0.0
    add_column :plans, :periodicity, :string, default: 'monthly'
  end
end
