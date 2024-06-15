class CreateBusinessUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :business_units do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    # Índice na chave estrangeira
    add_index :business_units, :user_id
  end
end
