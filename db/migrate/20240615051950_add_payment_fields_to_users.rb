class AddPaymentFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :payment_status, :string, default: 'pending'
    add_column :users, :payment_due_date, :datetime
    add_column :users, :plan_id, :integer
    add_index :users, :plan_id
    add_foreign_key :users, :plans
  end
end
