class ChangeOutbreakTable < ActiveRecord::Migration
  def change
    remove_column :outbreaks, :medical_condition_id
    add_column :outbreaks, :title, :string
    add_column :outbreaks, :description, :text
  end
end
