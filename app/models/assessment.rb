# Represents a collection of objective assessments for an offering
# As well as some general offering assessment data
#
class Assessment < ActiveRecord::Base
  belongs_to :offering
  has_many :objective_assessments

  validates_presence_of :offering
  validates_associated :objective_assessments


  def to_s
    %(#{objective_assessments.count} assessments of #{offering})
  end
end
