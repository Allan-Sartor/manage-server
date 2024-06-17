class AddLegalFieldsToBusinessUnits < ActiveRecord::Migration[7.0]
  def change
    add_column :business_units, :cnpj, :string
    add_column :business_units, :state_registration, :string
    add_column :business_units, :municipal_registration, :string
    add_column :business_units, :legal_name, :string
    add_column :business_units, :trade_name, :string
  end
end
