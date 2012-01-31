class AddOfferingIdToObjective < ActiveRecord::Migration
  def change
    add_column :objectives, :offering_id, :integer
  end
end
