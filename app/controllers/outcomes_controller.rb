# Outdated scaffold for outcomes
# TODO: Replace with outcome sets completely maybe?
#
class OutcomesController < ApplicationController
  respond_to :html, :json

  before_filter { @nav_section = :outcomes }
  before_filter :require_user
  authorize_resource

  def index
    @outcomes = Outcome.all
    respond_with @outcomes
  end

  def show
    @outcome = Outcome.find(params[:id])
    respond_with @outcome
  end

  def new
    @outcome = Outcome.new
    respond_with @outcome
  end

  def edit
    @outcome = Outcome.find(params[:id])
  end

  def create
    @outcome = Outcome.new(params[:outcome])

    respond_to do |format|
      if @outcome.save
        format.html { redirect_to @outcome,
          success: 'Outcome was successfully created.' }
      else
        format.html {
          flash[:error] = @outcome.errors.full_messages.to_sentence
          render action: "new"}
      end
    end
  end

  def update
    @outcome = Outcome.find(params[:id])

    respond_to do |format|
      if @outcome.update_attributes(params[:outcome])
        format.html { redirect_to @outcome,
          success: 'Outcome was successfully updated.' }
      else
        format.html {
          flash[:error] = @outcome.errors.full_messages.to_sentence
          render action: "edit"}
      end
    end
  end

  def destroy
    @outcome = Outcome.find(params[:id])
    @outcome.destroy

    respond_to do |format|
      format.html { redirect_to outcomes_url }
      format.json { head :ok }
    end
  end
end
