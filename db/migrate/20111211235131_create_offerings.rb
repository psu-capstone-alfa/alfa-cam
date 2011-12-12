class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.integer :course_id
      t.integer :term_id
      t.string :section
      t.string :crn
      t.string :location

      t.timestamps
    end
  end
end
