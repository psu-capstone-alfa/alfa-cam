# Contains the assessment of one offering objective
#
class ObjectiveAssessment < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :objective
  has_one :offering, through: :assessment

  validates_presence_of :assessment, :objective, :offering

  validate :objective_belongs_to_offering


  def to_s
    %(Assessment of #{objective} from #{offering})
  end



  private

  def objective_belongs_to_offering
    begin
      offering.objectives.find(objective)
    rescue Exception
      errors.add(:objective, "Invalid objective for this assessment")
    end
  end
end
