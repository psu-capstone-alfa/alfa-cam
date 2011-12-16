class Course < ActiveRecord::Base
  has_many :offerings

 #will show the fields
 def course_field
   "#{dept_code} #{course_num} #{title}"
 end
end
