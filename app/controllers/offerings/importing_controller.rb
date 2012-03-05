# Reviewing is the first stage of an offering.
# Shows the assessment of the last time this course was taught
#
class Offerings::ImportingController < Offerings::Children
  layout 'offering'

  before_filter { @nav_offering = :importing }
  before_filter :require_user

  def show
  end

  def edit
    @redirect_url = url_for [@offering, :details]
  end
end
