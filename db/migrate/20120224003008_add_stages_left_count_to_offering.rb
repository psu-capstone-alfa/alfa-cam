class AddStagesLeftCountToOffering < ActiveRecord::Migration
  def change
    add_column :offerings, :stages_left, :integer
  end
end
