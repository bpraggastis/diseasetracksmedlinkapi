class ChangeDiseaseIdInQueryRecordsToInteger < ActiveRecord::Migration
  def change
    remove_column :query_records, :disease_id
    add_column :query_records, :disease_id, :integer
  end
end
