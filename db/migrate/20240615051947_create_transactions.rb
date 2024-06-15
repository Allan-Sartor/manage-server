class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.string :description, null: false
      t.string :transaction_type, null: false
      t.string :payment_type, null: false
      t.references :business_unit, null: false, foreign_key: true

      t.timestamps
    end

    # Índice na chave estrangeira e nos tipos de transação e pagamento
    add_index :transactions, :transaction_type
    add_index :transactions, :payment_type
  end
end
