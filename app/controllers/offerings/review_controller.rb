# Reviewing is the first stage of an offering.
# Shows the assessment of the last time this course was taught
#
class Offerings::ReviewController < Offerings::Children
  layout 'offering'

  include Offerings::Recent

  before_filter { @nav_offering = :review }
  before_filter :require_user
  before_filter :get_recent_offering_choice
  before_filter :get_recent_offering_choices
  before_filter :get_recent_offering_assessment

  def show
  end

  def edit
    @redirect_url = url_for [:edit, @offering]
  end

  private
    def get_recent_offering_assessment
      @assessment = @recent_offering_choice.try :assessment
    end
end
