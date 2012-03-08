class AddOutcomeGroupIdToOutcome < ActiveRecord::Migration
  def change
    add_column :outcomes, :outcome_group_id, :integer

  end
end
