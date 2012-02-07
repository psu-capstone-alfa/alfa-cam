class CreateOutcomeGroups < ActiveRecord::Migration
  def change
    create_table :outcome_groups do |t|
      t.integer :initial_term_id
      t.string :title

      t.timestamps
    end
  end
end
