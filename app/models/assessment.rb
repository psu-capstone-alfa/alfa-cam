# Represents a collection of objective assessments for an offering
# As well as some general offering assessment data
#
class Assessment < ActiveRecord::Base
  belongs_to :offering
  has_many :objective_assessments, dependent: :destroy do
    def find_or_create_by_objective(objective)
      find_or_create_by_objective_id(objective.id)
    end
  end

  validates_presence_of :offering
  validates_associated :objective_assessments

  def create(*)
    super
    create_objective_assessments
  end

  def create!(*)
    super
    create_objective_assessments
  end

  def create_objective_assessments
    offering.objectives.each do |objective|
      objective_assessments.find_or_create_by_objective(objective)
    end
    self
  end

  def to_s
    %(#{objective_assessments.count} assessments of #{offering})
  end
end
