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
    @offerings = Offering.all
    respond_with @offerings, layout: 'application'
  end

  def show
    @nav_offering = :summary
    respond_with @offering
  end

  def new
    respond_with @offering
  end

  def edit
    @nav_offering = :manage
  end

  def create
    @offering = Offering.new(params[:offering])

    respond_to do |format|
      if @offering.save
        format.html {
          redirect_to @offering, notice: 'Offering was successfully created.'
        }
        format.json {
          render json: @offering, status: :created, location: @offering
        }
      else
        format.html { render action: "new" }
        format.json {
          render json: @offering.errors, status: :unprocessable_entity
        }
      end
    end
  end

  def update
    respond_to do |format|
      if @offering.update_attributes(params[:offering])
        format.html {
          redirect_to @offering, notice: 'Offering was successfully updated.'
        }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json {
          render json: @offering.errors, status: :unprocessable_entity
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
    instructors = Array.new
    User.with_role(:instructor).all.each {
      |inst| instructors << {
        :label => inst.name,
        :value => "#{inst.id}_#{inst.to_s.gsub(/\s/, '_')}"
      }
    }
    
    terms = Array.new
    AcademicTerm.all.each {
      |term| terms << {
        :label => term.title,
        :value => "#{term.id}_#{term.to_s.gsub(/\s/, '_')}"
      }
    }
    
    crns = Offering.find(:all, :select => "crn").map(&:crn)
    
    obj = {
      "instructors" => instructors,
      "terms"       => terms,
      "crns"        => crns
    }
    
    ActiveSupport::JSON.encode(obj)
    
    respond_to do |format|
      format.json { render :json => obj }
    end
  end
  
  def search
    conditions = Hash.new
    conditions[:term_id] = params[:term].to_i unless params[:term].blank?
    conditions[:users] = {:id => params[:instructor].to_i} unless params[:instructor].blank?
    conditions[:crn] = params[:crn].to_i unless params[:crn].blank?
    @offerings = Offering.joins(:instructors).where(conditions).uniq
    if params[:partial].blank?
      respond_with @offerings, :layout => 'application'
    else
      render :partial => 'search_table', :layout => false
    end
    
  end

=begin
    def search
      @offerings = Offering.all
      respond_with @offerings
    end
=end

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
