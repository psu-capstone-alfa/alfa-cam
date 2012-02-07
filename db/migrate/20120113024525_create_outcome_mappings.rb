class CreateOutcomeMappings < ActiveRecord::Migration
  def change
    create_table :outcome_mappings do |t|
      t.integer :outcome_group_id
      t.integer :outcome_id

      t.timestamps
    end
  end
end
