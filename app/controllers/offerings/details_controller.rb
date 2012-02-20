# Second stage of an offering. Collects syllabus details about an offering.
#
class Offerings::DetailsController < OfferingsController
  layout 'offering'

  before_filter { @nav_offering = :details }
  before_filter :require_user

  def edit
    @offering = Offering.find(params[:offering_id])
  end

  def show
    @offering = Offering.find(params[:offering_id])
    @course = @offering.course
    @term = @offering.term
    @instructors = @offering.instructors
    @outcomes = @offering.outcomes
    @objectives = @offering.objectives
  end

  def update
  end

  def destroy
  end
end
