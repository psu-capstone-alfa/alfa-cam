class Course < ActiveRecord::Base
  has_many :offerings

  #ADD COMMENT
  has_many :replacements_from, class_name: 'CourseReplacement', foreign_key: 'replace_id'
  has_many :replacements_to, class_name: 'CourseReplacement', foreign_key: 'with_id'

  #ADD COMMENT
  has_many :replaces, through: :replacements_to
  has_many :replaced_with, through: :replacements_from

  # Cannot destroy course if offerings are related to it
  before_destroy :check_for_offerings
  
  #will show the fields
  def to_s
    "#{dept_code}#{course_num}: #{title}"
  end

  def course_field
    to_s
  end

  def check_for_offerings
    unless offering_ids.empty?
      self.errors[:base] << "Sorry, you cannot delete a course with offerings."
      false
    end
  end

end
