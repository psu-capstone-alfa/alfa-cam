# this controller is used to generate export files with specific format
class ExportController < ApplicationController
  # TODO: need to check !!!!
  skip_authorization_check
# action to search for offerings in the selected term
  def search
    if(params[:id].nil?)
      @term = nil
    else
      @term = AcademicTerm.find(params[:id])
    end
  end
end