# Reviewing is the first stage of an offering.
# Shows the assessment of the last time this course was taught
#
class Offerings::ReviewsController < OfferingsController
  layout 'offering'

  before_filter { @nav_offering = :review }

  def show
  end
end
