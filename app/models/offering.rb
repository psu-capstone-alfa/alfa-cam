# An offering is an instance of a course taught in a specific term
# by some number of instructors
#
class Offering < ActiveRecord::Base
  belongs_to :course
  belongs_to :term, class_name: 'AcademicTerm', foreign_key: 'term_id'
  has_many :outcomes, :through => :term
  has_many :objectives

  has_many :teachings
  has_many :instructors, through: :teachings

  validates :course_id, :term_id, :presence => true

  def to_s
    "#{term.short}-#{course.short}"
  end

  def self.exportHeadings
    return [
      "Dept", "Course Number", "Term", "Section", "CRN", "Instructor(s)", "Credits",
      "Day/Time", "Textbook", "Additional Textbook(s)", "Required", "Prerequisite(s)", "Location", "Program Outcomes", "Course Objectives"
    ]
  end

  def exportFields
    course = self.course
    term = self.term
    
    instructors = ""
    self.instructors.each { |instructor| instructors << instructor.name << "," }
    instructors.chomp!(",")
    
    outcomes = ""
    self.outcomes.each { |outcome| outcomes << outcome.key << "," }
    outcomes.chomp!(",")
    
    objectives = ""
    self.objectives.each { |objective| objectives << objective.description << "," }
    objectives.chomp!(",")
    
    return [
      course.dept_code, course.course_num, term.title,
      self.section, self.crn, instructors, self.credits, self.day_and_time, self.textbook, 
      self.additional_textbooks, self.required_or_elective, self.prerequisite, self.location, outcomes, objectives
    ]
  end
end
