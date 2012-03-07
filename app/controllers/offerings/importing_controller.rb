# Reviewing is the first stage of an offering.
# Shows the assessment of the last time this course was taught
#
class Offerings::ImportingController < Offerings::Children
  layout 'offering'

  include Offerings::Recent

  before_filter { @nav_offering = :importing }
  before_filter :require_user
  before_filter :get_recent_offering_choice
  before_filter :get_recent_offering_choices
  before_filter :get_recent_offering_summary

  def show
    redirect_to action: :edit
  end

  def edit
    @redirect_url = url_for [:edit, @offering]
  end

  def import
    imported_offering = Offering.find params[:import_from_id]
    case
      when imported_offering.nil?
        flash[:error] = 'Invalid import offering id'
        redirect_to action: :edit and return
      when ! imported_offering.completed?
        flash[:error] = 'Cannot import from uncomplete offering'
        redirect_to action: :edit and return
    end
    @offering.import_from imported_offering
    flash[:success] = 'Success: Imported offering details and mappings'
    redirect_to [:edit, @offering]
  end

  private
    def get_recent_offering_summary
      # Nothing here yet
    end
end
