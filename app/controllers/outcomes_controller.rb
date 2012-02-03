# Outdated scaffold for outcomes
# TODO: Replace with outcome sets completely maybe?
#
class OutcomesController < ApplicationController
  respond_to :html, :json

  def index
    @outcomes = Outcome.all
    authorize! :read, @outcomes
    respond_with @outcomes
  end

  def show
    @outcome = Outcome.find(params[:id])
    authorize! :read, @outcome
    respond_with @outcome
  end

  def new
    @outcome = Outcome.new
    authorize! :read, @outcome
    respond_with @outcome
  end

  def edit
    @outcome = Outcome.find(params[:id])
    authorize! :edit, @outcome
  end

  def create
    @outcome = Outcome.new(params[:outcome])
    authorize! :create, @outcome

    respond_to do |format|
      if @outcome.save
        format.html { redirect_to @outcome,
          notice: 'Outcome was successfully created.' }
        format.json { render json: @outcome,
          status: :created, location: @outcome }
      else
        format.html { render action: "new" }
        format.json { render json: @outcome.errors,
          status: :unprocessable_entity }
      end
    end
  end

  def update
    @outcome = Outcome.find(params[:id])
    authorize! :update, @outcome

    respond_to do |format|
      if @outcome.update_attributes(params[:outcome])
        format.html { redirect_to @outcome,
          notice: 'Outcome was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @outcome.errors,
          status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @outcome = Outcome.find(params[:id])
    authorize! :destroy, @outcome
    @outcome.destroy

    respond_to do |format|
      format.html { redirect_to outcomes_url }
      format.json { head :ok }
    end
  end
end
