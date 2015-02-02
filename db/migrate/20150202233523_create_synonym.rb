class CreateSynonym < ActiveRecord::Migration
  def change
    create_table :synonyms do |t|
      t.integer :medical_condition_id
      t.integer :alternate_name_id
      t.timestamps
    end
  end
end
