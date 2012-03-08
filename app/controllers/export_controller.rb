# this controller is used to generate export files with specific format
class ExportController < ApplicationController
  skip_authorization_check

  # generate single export files for each offerings:
  # each includes: contents, objectives, assessments
  def offerings
  	@offerings = Offering.all
  end

  def offering
  	@offering = Offering.find(4)
  end

end
