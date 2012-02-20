class CreateObjectiveAssessments < ActiveRecord::Migration
  def change
    create_table :objective_assessments do |t|
      t.integer :assessment_id
      t.integer :objective_id
      t.text :assessed
      t.text :well_met
      t.text :improved

      t.timestamps
    end
  end
end
