# A program outcome, used for mapping against objectives and content
#
class OutcomesController < ApplicationController
  before_filter { @nav_section = :outcomes }

  load_and_authorize_resource :outcome_group
  load_and_authorize_resource :outcome, through: :outcome_group, shallow: true

  NON_SHALLOW = [:index, :new, :create]
  before_filter :load_outcome_group, except: NON_SHALLOW

  def index
  end

  def show
  end

  def new
    @outcome.outcome_group = @outcome_group
  end

  def edit
  end

  def create
    if @outcome.save
      flash[:success] = "Outcome successfully created."
      redirect_to [@outcome_group, Outcome]
    else
      render action: "new"
    end
  end

  def update
    if @outcome.update_attributes(params[:outcome])
      flash[:success] = "Outcome successfully updated."
      redirect_to [@outcome_group, Outcome]
    else
      render action: "edit"
    end
  end

  def destroy
    if @outcome.destroy
      redirect_to outcomes_url
    else
      flash[:errors] = "Could not delete Offering"
      redirect_to :back
    end
  end

  private
    def load_outcome_group
      @outcome_group = @outcome.outcome_group
    end
end
