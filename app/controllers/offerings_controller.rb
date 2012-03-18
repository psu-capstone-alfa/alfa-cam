require 'csv'

# Manages the basic listing, searching, management of offerings
# Offerings:: sub-controllers manage most of the instructor interactions
#
class OfferingsController < ApplicationController
  respond_to :html, :json
  authorize_resource class: Offering

  layout 'offering', only: [:show, :new, :edit]

  before_filter { @nav_section = :offerings }
  before_filter :find_resource, except: [:index, :create]
  before_filter :redirect_summary_before_import, only: :show

  def getConditions
    conditions = Hash.new
    conditions[:users] = {
      :id => params[:instructor].to_i
    } unless params[:instructor].blank?
    conditions[:crn] = params[:crn] unless params[:crn].blank?
    conditions[:course] = params[:course].split(" ")\
      unless params[:course].blank?
    conditions[:term_id] = params[:term].to_i unless params[:term].blank?
    start_term = params[:start_term].nil? ? nil : params[:start_term].to_i
    end_term = params[:end_term].nil? ? nil : params[:end_term].to_i
    conditions[:term_range] = [
      start_term,
      end_term
    ]
    conditions
  end

  def index
    conditions = getConditions
    @page = params[:page] or 1
    @limit = params[:limit] or 25

    @offerings = Offering.
      search_for(conditions).
      page(@page).
      per(@limit)

    if params[:partial].blank?
      respond_with @offerings, :layout => 'application'
    else
      render :partial => 'offerings_table', :layout => false
    end
  end

  def show
    @offering = Offering.find(params[:id])
    @nav_offering = :summary
    respond_with @offering
  end

  def new
    @offering = Offering.new
    respond_with @offering
  end

  def edit
    if @offering.taught_by? current_user
      # Redirect to the first non-complete stage
      @offering.stage.each do |stage,phase|
        redirect_to [@offering, stage] and return unless phase == :complete
      end
      # Or to details if all stages are complete
      redirect_to @offering and return
    end
    render
  end

  def create
    @offering = Offering.new(params[:offering])

    respond_to do |format|
      if @offering.save
        format.html {
          redirect_to @offering, success: 'Offering was successfully created.'
        }
      else
        format.html {
          flash[:error] = @offering.errors.full_messages.to_sentence
          render action: "new"
        }
      end
    end
  end

  def update
    respond_to do |format|
      if @offering.update_attributes(params[:offering])
        format.html {
          redirect_to @offering, success: 'Offering was successfully updated.'
        }
      else
        format.html {
          flash[:error] = @offering.errors.full_messages.to_sentence
          render action: "edit"
        }
      end
    end
  end

  def destroy
    @offering.destroy

    respond_to do |format|
      format.html { redirect_to offerings_url }
      format.json { head :ok }
    end
  end

  def facets
    obj = {}
    termFacets = AcademicTerm.facets
    obj["Instructor"] = User.with_role(:instructor).facets
    obj["Term"] = termFacets
    obj["Start_Term"] = termFacets
    obj["End_Term"] = termFacets
    obj["Course"] = Course.courses
    obj["CRN"] = Offering.find(:all, :select => "crn").map(&:crn).compact!

    ActiveSupport::JSON.encode(obj)

    render :json => obj
  end

  def export
    @offerings = Offering

    respond_to do |format|
      format.csv {
        render :csv => @offerings,
          :filename => "offerings-#{Time.now.strftime('%Y%m%d-%H%M%S')}"
      }
    end
  end

  # export for a single offering
  def export_member
    respond_to do |format|
      format.pdf {
        render
      }
    end
  end

  private

  def find_resource
    @offering = case
      when params.has_key?(:offering_id)
        Offering.find params[:offering_id]
      when params.has_key?(:id)
        Offering.find params[:id]
      else
        Offering.new
    end
  end

  def redirect_summary_before_import
    return if @offering.is_complete?(:importing)
    case
      when @offering.is_complete?(:review)
        redirect_to [@offering, :importing]
      else
        redirect_to [@offering, :review]
    end
  end

end
