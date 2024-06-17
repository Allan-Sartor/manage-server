class AddTrialEndDateToBusinessUnits < ActiveRecord::Migration[7.0]
  def change
    add_column :business_units, :trial_end_date, :timestamptz
  end
end
