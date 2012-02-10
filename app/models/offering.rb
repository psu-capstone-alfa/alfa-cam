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

  has_many :content_groups do
    def build_with_content
      new_group = self.build
      new_group.content.build_with_mappings(proxy_association.owner.outcomes)
      return new_group
    end
  end
  has_many :content, :through => :content_groups

  # don't accept unnamed content groups with no content attributes
  accepts_nested_attributes_for :content_groups, reject_if: ->(cg) do
    cg['name'].blank? and (cg['content_attributes'].all? do |i,c|
                             ContentGroup::REJECT.call(c)
                           end)
  end

  validates :course_id, :term_id, :presence => true
  validates_associated :content_groups

  def prepare_content_groups
    content_groups.each {|cg| cg.content.build_with_mappings(term.outcomes) }
    content_groups.build_with_content
  end

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
