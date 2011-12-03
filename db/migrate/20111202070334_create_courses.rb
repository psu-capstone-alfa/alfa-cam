class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :dept_code
      t.string :course_num
      t.string :title

      t.timestamps
    end
  end
end
