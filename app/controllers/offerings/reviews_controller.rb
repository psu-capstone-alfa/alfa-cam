# Reviewing is the first stage of an offering.
# Shows the assessment of the last time this course was taught
#
class Offerings::ReviewsController < Offerings::Children
  layout 'offering'

  before_filter { @nav_offering = :review }
  before_filter :require_user

  def show
  end
end
