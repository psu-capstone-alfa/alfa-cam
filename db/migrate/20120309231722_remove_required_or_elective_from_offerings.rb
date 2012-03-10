class RemoveRequiredOrElectiveFromOfferings < ActiveRecord::Migration
  def up
    remove_column :offerings, :required_or_elective
  end

  def down
    add_column :offerings, :required_or_elective, :string
  end
end
