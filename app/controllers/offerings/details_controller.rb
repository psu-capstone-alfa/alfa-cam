# Second stage of an offering. Collects syllabus details about an offering.
#
class Offerings::DetailsController < OfferingsController
  layout 'offering'

  before_filter { @nav_offering = :details }

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end
end
