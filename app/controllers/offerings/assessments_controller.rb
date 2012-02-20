# Assessments are the last stage of an offering.
# Collects evaluations/comments of a course's objectives
#
class Offerings::AssessmentsController < Offerings::Children
  layout 'offering'

  before_filter { @nav_offering = :assessment }
  before_filter :require_user

  def summary
  end

  def edit
  end

  def show
  end

end
