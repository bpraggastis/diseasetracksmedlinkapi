class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :medical_condition_id, :integer
    add_column :events, :outbreak_id, :integer
    add_column :events, :geo_id, :integer

    remove_column :events, :end_date
    remove_column :events, :duration
    remove_column :events, :status

    rename_column :events, :start_date, :date
  end
end
