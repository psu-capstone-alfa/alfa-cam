# A set of outcomes which can be applied to terms
#
class OutcomeGroupsController < ApplicationController
  before_filter { @nav_section = :outcomes }
  load_and_authorize_resource

  def index
  end

  def show
    redirect_to [@outcome_group, :outcomes]
  end

  def new
  end

  def edit
  end

  def create
    if @outcome_group.save
      flash[:success] = "Outcome Group successfully created."
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def update
    if @outcome_group.update_attributes(params[:outcome_group])
      flash[:success] = "Outcome Group successfully updated."
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  def destroy
    @outcome.destroy
    redirect_to action: :index
  end
end
