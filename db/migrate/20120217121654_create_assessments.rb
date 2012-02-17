class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.integer :offering_id
      t.text :comments
      t.text :improved

      t.timestamps
    end
  end
end
