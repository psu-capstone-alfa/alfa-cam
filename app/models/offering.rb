# An offering is an instance of a course taught in a specific term
# by some number of instructors
#
class Offering < ActiveRecord::Base

  # Stage state functionality
  include OfferingState
  before_save :update_stages_complete
  scope :order_by_status,
    order("stages_left DESC")
  scope :uncompleted, where('stages_left > 0')
  scope :completed, where('stages_left = 0')



  belongs_to :course
  belongs_to :term, class_name: 'AcademicTerm', foreign_key: 'term_id'
  has_many :outcomes, :through => :term
  has_many :objectives, dependent: :destroy

  has_many :teachings, dependent: :destroy
  has_many :instructors, through: :teachings

  DETAILS = [
              :section,
              :crn,
              :location,
              :credits,
              :day_and_time,
              :required_for_bsce,
              :required_for_bsenve,
              :prerequisites,
              :textbook,
              :additional_textbooks,
              :description
            ]

  IMPORTED_DETAILS = DETAILS - [:section, :crn, :location, :day_and_time]

  REQUIRED_DETAILS = DETAILS - [:prerequisites,
                                :textbook,
                                :additional_textbooks]

  validates_presence_of REQUIRED_DETAILS, if: lambda {|o| o.details_done }

  accepts_nested_attributes_for :teachings
  validates_associated :teachings

  ## Assessments
  has_one :assessment, include: :objective_assessments, dependent: :destroy
  has_many :objective_assessments, through: :assessment
  accepts_nested_attributes_for :assessment, :objective_assessments
  def get_or_create_assessment
    return assessment.create_objective_assessments unless assessment.nil?
    create_assessment!
  end


  ## Contents
  def prepare_content_groups
    missing_names = ContentGroupName.active.all - content_group_names
    missing_names.each do |missing_name|
      content_group_names << missing_name
    end
    content_groups.each do |cg|
      cg.content.build_with_mappings(term.outcomes)
    end
  end

  has_many :content_groups, dependent: :destroy
  has_many :content_group_names, through: :content_groups
  has_many :content, through: :content_groups


  # don't accept unnamed content groups with no content attributes
  accepts_nested_attributes_for :content_groups #, reject_if: ->(cg) do
  #  cg['name'].blank? and
  #  (cg['content_attributes'].all? do |i,c|
  #    ContentGroup::REJECT.call(c)
  #  end)
  #end
  accepts_nested_attributes_for :objectives,
    allow_destroy: true,
    reject_if: ->(obj) { obj['description'].blank? }

  validates :course_id, :term_id, :presence => true
  validates_associated :content_groups

  # Scope
  scope :for_term, lambda {|term| where(:term_id => term.id); }
  scope :course_order,
    includes(:course).
    order("courses.dept_code ASC, courses.course_num ASC")
  scope :with_instructors,
    includes(:instructors).
    order("users.name ASC")
  scope :term_order,
    order("term_id DESC")
  scope :before_or_during, lambda { |term|
    where('term_id <= ?', term.id)
  }
  scope :by_course, lambda { |course|
    if course.nil?
      return nil
    end
    where('courses.dept_code = ? AND courses.course_num = ?',
          course[0], course[1])
  }
  # Expects a two element array that contains the id's of a start term
  # and an end term, either of which can be nil
  scope :with_term_range, lambda { |term_range|
    if term_range.nil?
      return nil
    end
    start_term = term_range[0]
    end_term = term_range[1]
    if start_term.nil? && end_term.nil?
      return nil
    elsif !start_term.nil? && end_term.nil?
      where('term_id >= ?', start_term)
    elsif start_term.nil? && !end_term.nil?
      where('term_id <= ?', end_term)
    else
      where('term_id >= ? AND term_id <= ?', start_term, end_term)
    end
  }
  scope :search_for, lambda { |conditions|
    includes(:instructors, :course, :term).
    term_order.
    course_order.
    by_course(conditions.delete(:course)).
    with_term_range(conditions.delete(:term_range)).
    where(conditions) # we should slice out only allowed searching attrs
  }

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
      'Description',
      'Term',
      'Section',
      'CRN',
      'Instructor(s)',
      'Credits',
      'Day/Time',
      'Textbook',
      'Additional Textbook(s)',
      'BSCE Requirement',
      'BSENVE Requirement',
      'Prerequisite(s)',
      'Location',
      'Program Outcomes',
      'Course Objectives',
      'Content'
    ]
  end

  def export_fields
    joined_instructors = instructors.map(&:name).join(',')

    joined_outcomes = outcomes.map(&:key).join(',')

    joined_objectives = objectives.map(&:description).join(',')

    joined_content = content.map(&:title).join("; ").chomp " "

    return [
      course.dept_code,
      course.course_num,
      description,
      term.title,
      section,
      crn,
      joined_instructors,
      credits,
      day_and_time,
      textbook,
      additional_textbooks,
      required_for_bsce,
      required_for_bsenve,
      prerequisites,
      location,
      joined_outcomes,
      joined_objectives,
      joined_content
    ]
  end

  def import_from(offering)
    update_attributes(
      offering.attributes.select do |key, v|
        IMPORTED_DETAILS.include? key.to_sym
      end
    )

    if can_import_mappings_from? offering
      import_with_mappings(offering)
    else
      import_without_mappings(offering)
    end

    self.importing_done = true
    save
  end

  def import_with_mappings(offering)
    offering.objectives.each do |objective|
      objective.clones_with_mapping(self)
    end
    offering.content_groups.each do |group|
      group.clones_with_mappings(self)
    end
  end

  def import_without_mappings(offering)
    offering.objectives.each do |objective|
      objective.clones_without_mapping(self)
    end
    offering.content_groups.each do |group|
      group.clones_without_mappings(self)
    end
  end

  def can_import_mappings_from?(other_offering)
    self.term.outcome_group == other_offering.term.outcome_group
  end

  def self.content_to_outcome_mapping_row_total
    10
  end


  def summed_mappings
    outcomes.map do |outcome|
      objectives.
      includes(:mappings).
      where(mappings: {outcome_id: outcome, value: 1}).count
    end
  end


end
