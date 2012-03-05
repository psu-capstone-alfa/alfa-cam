require 'csv'

# Manages the basic listing, searching, management of offerings
# Offerings:: sub-controllers manage most of the instructor interactions
#
class OfferingsController < ApplicationController
  respond_to :html, :json
  before_filter :require_user
  authorize_resource class: Offering

  layout 'offering', only: [:show, :new, :edit]

  before_filter { @nav_section = :offerings }
  before_filter :find_resource, except: [:index, :create]

  def index
    @offerings = Offering.order(:term_id).page params[:page]
    respond_with @offerings, layout: 'application'
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
    puts @offering
    puts current_user
    if @offering.taught_by? current_user
      # Redirect to the first non-complete stage
      @offering.stage.each do |stage,phase|
        redirect_to [@offering, stage] and return unless phase == :complete
      end
      # Or to details if all stages are complete
      redirect_to [:edit, @offering, :details]
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
    obj["Instructor"] = User.with_role(:instructor).facets
    obj["Term"] = AcademicTerm.facets
    obj["CRN"] = Offering.find(:all, :select => "crn").map(&:crn).compact!

    ActiveSupport::JSON.encode(obj)

    render :json => obj
  end

  def search
    conditions = Hash.new
    conditions[:term_id] = params[:term].to_i unless params[:term].blank?
    conditions[:users] = {
      :id => params[:instructor].to_i
    } unless params[:instructor].blank?
    conditions[:crn] = params[:crn] unless params[:crn].blank?
    @offerings = Offering.joins(:instructors).where(conditions).uniq
    if params[:partial].blank?
      respond_with @offerings, :layout => 'application'
    else
      render :partial => 'search_table', :layout => false
    end

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


end
