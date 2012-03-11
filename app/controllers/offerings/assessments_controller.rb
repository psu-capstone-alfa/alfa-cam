# Assessments are the last stage of an offering.
# Collects evaluations/comments of a course's objectives
#
class Offerings::AssessmentsController < Offerings::Children
  layout 'offering'

  before_filter { @nav_offering = :assessments }

  def summary
  end

  def edit
    @assessment = @offering.get_or_create_assessment
    @objective_assessments = @assessment.objective_assessments
  end

  def show
    @assessment = @offering.assessment
    render 'no_assessment' and return if @assessment.nil?
  end

end
