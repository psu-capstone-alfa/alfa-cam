# Assessments are the last stage of an offering.
# Collects evaluations/comments of a course's objectives
#
class Offerings::AssessmentsController < OfferingsController
  layout 'offering'

  before_filter { @nav_offering = :assessment }

  def summary
  end

  def edit
  end

  def show
  end

end
