class ChangeOfferingsRequiredFields < ActiveRecord::Migration
  def up
    change_column :offerings, :required_for_bsce, :string, :default => "N/A", :null => "N/A"
    change_column :offerings, :required_for_bsenve, :string, :default => "N/A", :null => "N/A"
  end

  def down
    change_column :offerings, :required_for_bsce, :boolean, :default => false, :null => false
    change_column :offerings, :required_for_bsce, :boolean, :default => false, :null => false
  end
end
