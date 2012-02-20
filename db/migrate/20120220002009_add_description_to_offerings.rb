class AddDescriptionToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :description, :text
  end
end
