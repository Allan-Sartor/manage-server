class AddMaxBusinessUnitsToPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :max_business_units, :integer, default: 1
  end
end
