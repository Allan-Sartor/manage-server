class CreateInventoryItems < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_items do |t|
      t.string :name, null: false
      t.integer :quantity, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.string :item_type, null: false
      t.references :business_unit, null: false, foreign_key: true

      t.timestamps
    end

    # Índice na chave estrangeira e no nome do item
    add_index :inventory_items, :name
    add_index :inventory_items, :item_type
  end
end
