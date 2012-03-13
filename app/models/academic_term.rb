# Academic terms are a period of time in which courses are taught
#
class AcademicTerm < ActiveRecord::Base
  default_scope order("id DESC")
  validates :title, :presence => true

  has_many :offerings, foreign_key: :term_id


  belongs_to :outcome_group, inverse_of: :terms
  has_many :outcomes, through: :outcome_group

  validates :title, :presence => true

  validates_associated :offerings
  accepts_nested_attributes_for :offerings, allow_destroy: true

  before_destroy :check_for_offerings
  def check_for_offerings()
    unless offerings.empty?
      self.errors[:base] << "Sorry, you cannot delete a term with offerings."
      false
    end
  end

  # "Fa'12" or "Wi'12"
  def short
    #season, year = title.split(/\s+/)
    #"#{season.first(2)}'#{year.last(2)}"
    self
  end

  def to_s
    title
  end

  def available_courses
    Course.available_during(self)
  end

  def self.current
    first
  end

  def self.facets
    AcademicTerm.all.map { |term|
      {
        :label => term.title,
        :value => "#{term.id}_#{term.to_s.gsub(/\s/, '_')}"
      }
    }
  end

  # Order Scopes
  scope :order_oldest_first, order('id DESC')
end
