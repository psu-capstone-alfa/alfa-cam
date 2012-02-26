# Collecting course objectives in the third stage.
# Objectives are mapped in a binary fashion against outcomes
#
class Offerings::ObjectivesController < Offerings::Children
  layout 'offering'

  before_filter :require_user
  before_filter do
    @nav_offering = :objectives
    @offering = Offering.find params[:offering_id]
  end

  def summary
  end

  def edit
    @outcomes = @offering.outcomes
    @objectives = @offering.objectives
    @new_objective = Objective.new
    @new_objective.mappings = @outcomes.map do |outcome|
      Mapping.new mappable: @new_objective, outcome: outcome
    end
  end

  def show
    @outcomes = @offering.outcomes
    @objectives = @offering.objectives
  end

end
