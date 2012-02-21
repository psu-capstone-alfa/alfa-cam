require 'csv'

# Manages the basic listing, searching, management of offerings
# Offerings:: sub-controllers manage most of the instructor interactions
#
class OfferingsController < ApplicationController
  respond_to :html, :json
  before_filter :require_user
  authorize_resource class: Offering

  layout 'offering', except: [:index, :new]

  before_filter { @nav_section = :offerings }
  before_filter :find_resource, except: [:index, :create]

  def index
    @offerings = Offering.all
    respond_with @offerings, layout: 'application'
  end

  def show
    @nav_offering = :overview
    respond_with @offering
  end

  def new
    respond_with @offering
  end

  def edit
    @nav_offering = :overview
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

  def search
    @offerings = Offering.all
    respond_with @offerings
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

  def redirect_to(*args)
    if params[:_redirect_endpoint]
      args[0] = params[:_redirect_endpoint]
    end
    super(*args)
  end
end
