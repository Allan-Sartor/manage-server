class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.references :business_unit, null: false, foreign_key: true

      t.timestamps
    end

    # Índice na chave estrangeira e no email para consultas rápidas
    add_index :clients, :email
  end
end
