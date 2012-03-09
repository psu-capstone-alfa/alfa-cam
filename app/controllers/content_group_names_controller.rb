# For ContentGroupNames, which control the availability of which
# ContentGroups a new offering can have
class ContentGroupNamesController < ApplicationController
  before_filter :require_user
  authorize_resource

  # GET /content_group_names
  # GET /content_group_names.json
  def index
    @content_group_names = ContentGroupName.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @content_group_names }
    end
  end

  # GET /content_group_names/1
  # GET /content_group_names/1.json
  def show
    @content_group_name = ContentGroupName.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @content_group_name }
    end
  end

  # GET /content_group_names/new
  # GET /content_group_names/new.json
  def new
    @content_group_name = ContentGroupName.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @content_group_name }
    end
  end

  # GET /content_group_names/1/edit
  def edit
    @content_group_name = ContentGroupName.find(params[:id])
  end

  # POST /content_group_names
  # POST /content_group_names.json
  def create
    @content_group_name = ContentGroupName.new(params[:content_group_name])

    respond_to do |format|
      if @content_group_name.save
        format.html do
          flash[:notice] = "Content group name was successfully created."
          redirect_to @content_group_name
        end
        format.json do
          render json: @content_group_name,
                 status: :created,
                 location: @content_group_name
        end
      else
        format.html do
          render action: "new"
        end
        format.json do
          render json: @content_group_name.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PUT /content_group_names/1
  # PUT /content_group_names/1.json
  def update
    @content_group_name = ContentGroupName.find(params[:id])

    respond_to do |format|
      if @content_group_name.update_attributes(params[:content_group_name])
        format.html do
          flash[:notice] = "Content group name was successfully updated."
          redirect_to @content_group_name
        end
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json do
          render json: @content_group_name.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /content_group_names/1
  # DELETE /content_group_names/1.json
  def destroy
    @content_group_name = ContentGroupName.find(params[:id])
    @content_group_name.destroy

    respond_to do |format|
      format.html { redirect_to content_group_names_url }
      format.json { head :ok }
    end
  end
end
