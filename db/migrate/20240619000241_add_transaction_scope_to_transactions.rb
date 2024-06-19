class AddTransactionScopeToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :transaction_scope, :string
  end
end
