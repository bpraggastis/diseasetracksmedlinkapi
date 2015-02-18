class AddColumnGeos < ActiveRecord::Migration
  def change
    add_column :geos, :county, :string
    add_column :geos, :place_id, :integer
  end
end
