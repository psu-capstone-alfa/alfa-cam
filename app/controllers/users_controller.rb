# Manage user accounts and details
#
class UsersController < ApplicationController
  before_filter :require_user, only: :show

  def show
    @nav_section = :profile
    @user = current_user
  end
end
