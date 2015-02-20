class ReassigningColumnsInQueryRecords < ActiveRecord::Migration
  def change
    change_table :query_records do |t|
      t.integer :outbreak_id
      t.rename :disease, :disease_id
      t.integer :place_id
      t.remove :location
    end
  end
end
