# Reviewing is the first stage of an offering.
# Shows the assessment of the last time this course was taught
#
class Offerings::ReviewController < Offerings::Children
  layout 'offering'

  before_filter { @nav_offering = :review }
  before_filter :require_user
  before_filter :get_reviewing_offering
  before_filter :get_review_choices

  def show
  end

  def edit
    @redirect_url = url_for [:edit, @offering]
  end

  private
    def get_reviewing_offering
      if params.has_key? :review_id
        @reviewing_offering = Offering.find params[:review_id]
      end
      @reviewing_offering ||= @offering.course.recent_offerings.first
      @assessment = @reviewing_offering.assessment if @reviewing_offering
    end

    def get_review_choices
      @recent = @course.recent_offerings.map do |offering|
        [offering, offering.id]
      end
      @my_recent = @course.
        recent_offerings_taught_by(current_user).map do |o|
          [o, o.id]
      end
    end
end
