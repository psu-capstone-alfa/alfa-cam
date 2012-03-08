class AddPositionToOutcome < ActiveRecord::Migration
  def change
    add_column :outcomes, :position, :integer

  end
end
