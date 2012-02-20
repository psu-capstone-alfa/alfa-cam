# Collecting course contents is the fourth stage of offerings.
# Contents are collected in groups(Lectures, Assignments, ..)
# and mapped in a numeric(0-10) fashion against outcomes
#
class Offerings::ContentController < Offerings::Children
  layout 'offering'

  before_filter do
    @nav_offering = :content
    @offering = Offering.find params[:offering_id]
  end

  def summary
  end

  def edit
    @offering.prepare_content_groups
    @outcomes = @offering.outcomes
  end

  def show
  end

end
