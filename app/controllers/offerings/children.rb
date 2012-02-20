class Offerings::Children < OfferingsController

  before_filter :redirect_to_edit, only: [:show]

private

  def redirect_to_edit
    if @offering.taught_by? current_user and
        not @offering.completed? and
        @offering.is_ready? controller_name
      redirect_to action: 'edit'
    end
  end
end
