class CreateAlternateName < ActiveRecord::Migration
  def change
    create_table :alternate_names do |t|
      t.string :name
      t.timestamps
    end
  end
end
