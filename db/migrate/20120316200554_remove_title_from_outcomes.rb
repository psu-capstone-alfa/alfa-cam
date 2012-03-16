class RemoveTitleFromOutcomes < ActiveRecord::Migration
  def up
    remove_column :outcomes, :title
  end

  def down
    add_column :outcomes, :title, :string
  end
end
