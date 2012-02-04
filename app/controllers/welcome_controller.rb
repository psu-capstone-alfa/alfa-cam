# Contains the default home page
# TODO: Should contain some helpful information and links
class WelcomeController < ApplicationController

  def home
    @nav_section = :home
  end

end
