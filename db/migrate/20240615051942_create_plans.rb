class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.decimal :price, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
