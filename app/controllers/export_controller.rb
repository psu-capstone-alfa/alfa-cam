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
    respond_to do |format|
      format.html{
      	render
      }
      format.pdf {
        render
      }
    end
  end

# action to search for offerings in the selected term
  def search
    if(params[:id].nil?)
      @term = AcademicTerm.find(1)  
    else
      @term = AcademicTerm.find(params[:id])
    end
  end

end
