class CreateCourseReplacements < ActiveRecord::Migration
  def change
    create_table :course_replacements do |t|
      t.integer :replace_id
      t.integer :with_id

      t.timestamps
    end
  end
end
