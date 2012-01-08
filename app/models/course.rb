class Course < ActiveRecord::Base
  has_many :offerings

 #will show the fields
 def course_field
   "#{dept_code} #{course_num} #{title}"
 end
    
    
 has_many :replacements_from, class_name: 'CourseReplacement', foreign_key: 'replace_id'
 has_many :replacements_to, class_name: 'CourseReplacement', foreign_key: 'with_id'
    
 has_many :replaces, through: :replacements_to
 has_many :replaced_with, through: :replacements_from
    

end
