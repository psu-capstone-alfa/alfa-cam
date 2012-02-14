class AddPrerequisitesToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :prerequisites, :text
  end
end
