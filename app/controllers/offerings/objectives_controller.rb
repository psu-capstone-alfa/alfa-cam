# Collecting course objectives in the third stage.
# Objectives are mapped in a binary fashion against outcomes
#
class Offerings::ObjectivesController < OfferingsController
  layout 'offering'

  before_filter { @nav_offering = :objectives }
  before_filter :require_user

  def summary
  end

  def edit
  end

  def show
  end

end
