# An offering is an instance of a course taught in a specific term
# by some number of instructors
#
class Offering < ActiveRecord::Base
  belongs_to :course
  belongs_to :term, class_name: 'AcademicTerm', foreign_key: 'term_id'
  has_many :outcomes, :through => :term

  has_many :teachings
  has_many :instructors, through: :teachings

  validates :course_id, :term_id, :presence => true

  def to_s
    "#{term.short}-#{course.short}"
  end
end
