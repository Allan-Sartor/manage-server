# frozen_string_literal: true

class AddPlanToBusinessUnits < ActiveRecord::Migration[7.0]
  def change
    add_column :business_units, :plan_id, :integer, null: false
    add_column :business_units, :payment_due_date, :timestamptz
    add_column :business_units, :notification_date, :timestamptz

    add_foreign_key :business_units, :plans
  end
end
