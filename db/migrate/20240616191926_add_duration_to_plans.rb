class AddDurationToPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :duration, :string, null: false, default: 'monthly'
  end
end
