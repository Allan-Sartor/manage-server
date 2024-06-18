class CreateInventoryCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_categories do |t|
      t.string :name
      t.references :business_unit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
