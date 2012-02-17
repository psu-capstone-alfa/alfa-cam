# Contains the default home page
# TODO: Should contain some helpful information and links
class WelcomeController < ApplicationController
  skip_authorization_check

  def home
    @nav_section = :home
  end

end
