#An offering is an instance of a course taught in a specific term
class Offering < ActiveRecord::Base
  belongs_to :course
  belongs_to :term, class_name: 'AcademicTerm', foreign_key: 'term_id'

  validates :course_id, :term_id, :presence => true
end
