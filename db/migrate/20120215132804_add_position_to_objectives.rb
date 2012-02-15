class AddPositionToObjectives < ActiveRecord::Migration
  def change
    add_column :objectives, :position, :integer
  end
end
