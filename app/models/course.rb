#
class Course < ActiveRecord::Base
  has_many :offerings

  #ADD COMMENT
  has_many :replacements_from,
    class_name: 'CourseReplacement',
    foreign_key: 'replace_id'
  has_many :replacements_to,
    class_name: 'CourseReplacement',
    foreign_key: 'with_id'

  #ADD COMMENT
  has_many :replaces, through: :replacements_to
  has_many :replaced_with, through: :replacements_from

  #will show the fields
  def to_s
    "#{dept_code}#{course_num}: #{title}"
  end

  def course_field
    to_s
  end


end
