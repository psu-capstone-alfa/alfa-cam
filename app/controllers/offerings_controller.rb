require 'csv'

# Manages the basic listing, searching, management of offerings
# Offerings:: sub-controllers manage most of the instructor interactions
#
class OfferingsController < ApplicationController
  respond_to :html
  load_and_authorize_resource :academic_term
  load_resource through: :academic_term, shallow: true
  before_filter { @academic_term ||= @offering.try(:term) }
  authorize_resource

  layout 'offering', only: [:show, :edit]

  before_filter { @nav_section = :offerings }
  before_filter :redirect_summary_before_import, only: :show

  def index
    @nav_section = :terms
    @offerings = @academic_term.offerings.ordered
    @term = @academic_term
    @nav_term = :offerings
    render layout: 'term'
  end

  def search
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
      render :partial => 'offerings_search', :layout => false
    end
  end

  def show
    @nav_offering = :summary
  end

  def new
    @_form_record = @academic_term, @offering
    render layout: 'application'
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
    @offering = Offering.new
    @offering.assign_attributes(params[:offering])
    @offering.term = @academic_term

    if @offering.save
      flash[:success] = 'Offering successfully created.'
      redirect_to [@academic_term, :offerings]
    else
      flash[:error] = @offering.errors.full_messages.to_sentence
      render action: "new"
    end
  end

  def update
    if @offering.update_attributes(params[:offering])
      redirect_to @offering, success: 'Offering was successfully updated.'
    else
      flash[:error] = @offering.errors.full_messages.to_sentence
      render action: "edit"
    end
  end

  def destroy
    if @offering.destroy
      flash[:success] = "Offering successfully deleted"
      redirect_to :back
    else
      flash[:error] = "Could not delete offering"
      redirect_to :back
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

  def search_explanation
    render :partial => 'search_explanation', :layout => false
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

  # Export a single offering
  def export_member
    respond_to do |format|
      format.pdf
    end
  end

  private

  def redirect_summary_before_import
    case
      when ! @offering.taught_by?(current_user)
      when ! @offering.is_complete?(:review)
        redirect_to [@offering, :review]
      when ! @offering.is_complete?(:importing)
        redirect_to [@offering, :importing]
      else
    end
  end

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

end
