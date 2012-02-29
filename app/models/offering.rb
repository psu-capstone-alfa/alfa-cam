# An offering is an instance of a course taught in a specific term
# by some number of instructors
#
class Offering < ActiveRecord::Base
  include OfferingState

  belongs_to :course
  belongs_to :term, class_name: 'AcademicTerm', foreign_key: 'term_id'
  has_many :outcomes, :through => :term
  has_many :objectives

  has_many :teachings
  has_many :instructors, through: :teachings


  ## Assessments
  has_one :assessment, include: :objective_assessments
  has_many :objective_assessments, through: :assessment
  accepts_nested_attributes_for :assessment, :objective_assessments
  def get_or_create_assessment
    return assessment unless assessment.nil?
    create_assessment!
  end


  ## Contents
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
    cg['name'].blank? and
    (cg['content_attributes'].all? do |i,c|
      ContentGroup::REJECT.call(c)
    end)
  end
  accepts_nested_attributes_for :objectives,
    allow_destroy: true,
    reject_if: ->(obj) { obj['description'].blank? }

  validates :course_id, :term_id, :presence => true
  validates_associated :content_groups

  # Scope
  scope :course_order,
    includes(:course).
    order("courses.dept_code ASC, courses.course_num ASC")

  scope :with_instructors,
    includes(:instructors).
    order("users.name ASC")

  def prepare_content_groups
    content_groups.each do |cg|
      cg.content.build_with_mappings(term.outcomes)
    end
    content_groups.build_with_content
  end

  def to_s
    "#{term.short}-#{course.short}"
  end

  def taught_by?(instructor)
    instructors.include? instructor
  end

  def self.export_headings
    [
      'Dept',
      'Course Number',
      'Term',
      'Section',
      'CRN',
      'Instructor(s)',
      'Credits',
      'Day/Time',
      'Textbook',
      'Additional Textbook(s)',
      'Required',
      'Prerequisite(s)',
      'Location',
      'Program Outcomes',
      'Course Objectives'
    ]
  end

  def export_fields
    joined_instructors = instructors.map(&:name).join(',')

    joined_outcomes = outcomes.map(&:key).join(',')

    joined_objectives = objectives.map(&:description).join(',')

    return [
      course.dept_code,
      course.course_num,
      term.title,
      section,
      crn,
      joined_instructors,
      credits,
      day_and_time,
      textbook,
      additional_textbooks,
      required_or_elective,
      prerequisite,
      location,
      joined_outcomes,
      joined_objectives
    ]
  end

end
