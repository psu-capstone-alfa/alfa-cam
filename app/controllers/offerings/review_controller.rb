# Reviewing is the first stage of an offering.
# Shows the assessment of the last time this course was taught
#
class Offerings::ReviewController < Offerings::Children
  layout 'offering'

  before_filter { @nav_offering = :review }
  before_filter :require_user

  def show
  end

  def edit
    @redirect_url = url_for [@offering, :importing]
  end
end
