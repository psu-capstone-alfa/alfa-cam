#Manages Offerings which are courses taught in specific terms
class OfferingsController < ApplicationController
  respond_to :html, :json
  def index
    @offerings = Offering.all
    respond_with @offerings
  end

  def show
    @offering = Offering.find(params[:id])
    respond_with @offering
  end

  def new
    @offering = Offering.new
    respond_with @offering
  end

  def edit
    @offering = Offering.find(params[:id])
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
    @offering = Offering.find(params[:id])

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
    @offering = Offering.find(params[:id])
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
end
