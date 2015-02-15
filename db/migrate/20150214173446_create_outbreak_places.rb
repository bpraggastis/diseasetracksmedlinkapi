class CreateOutbreakPlaces < ActiveRecord::Migration
  def change
    create_table :outbreak_places do |t|
      t.integer :outbreak_id
      t.integer :place_id

      t.timestamps
    end
  end
end
