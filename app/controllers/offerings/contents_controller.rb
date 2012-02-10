# Collecting course contents is the fourth stage of offerings.
# Contents are collected in groups(Lectures, Assignemnts, ..)
# and mapped in a numeric(0-10) fashion against outcomes
#
class Offerings::ContentsController < OfferingsController
  layout 'offering'

  before_filter { @nav_offering = :content }

  def summary
  end

  def edit
  end

  def show
  end

end
