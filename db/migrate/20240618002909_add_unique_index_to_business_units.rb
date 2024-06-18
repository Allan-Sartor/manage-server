class AddUniqueIndexToBusinessUnits < ActiveRecord::Migration[7.0]
  def change
    add_index :business_units, [:cnpj, :user_id], unique: true
  end
end
