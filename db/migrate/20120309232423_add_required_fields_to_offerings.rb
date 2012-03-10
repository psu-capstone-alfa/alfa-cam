class AddRequiredFieldsToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :required_for_bsce, :boolean, :default => false, :null => false

    add_column :offerings, :required_for_bsenve, :boolean, :default => false, :null => false
  end
end
