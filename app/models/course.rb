# A course is identified by a subject, course number, and title
# Provides a basic identification of an offering
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

  # Term created/retired links
  belongs_to :created_term, class_name: 'AcademicTerm'
  belongs_to :retired_term, class_name: 'AcademicTerm'
  validates_presence_of :created_term

  # Cannot destroy course if offerings are related to it
  before_destroy :check_for_offerings

  # Course details are required
  validates_presence_of :dept_code, :course_num, :title

  #
  # Scopes
  #
  default_scope order("dept_code ASC, course_num ASC, title ASC")
  scope :ordered, {}

  #will show the fields
  def to_s
    "#{short}: #{title}"
  end

  def short
    "#{dept_code} #{course_num}"
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

  def self.available_during(term)
    where("created_term_id <= ?", term.id).
    where("retired_term_id >= ? OR retired_term_id IS NULL", term.id)
  end

  # Querying recent offerings for a course
  def recent_offerings
    offerings.order(:term_id).completed
  end

  # Restrict to a specific instructor
  def recent_offerings_taught_by(instructor)
    recent_offerings.
      joins(:instructors).
      where(:users => {:id => instructor.id })
  end

end
