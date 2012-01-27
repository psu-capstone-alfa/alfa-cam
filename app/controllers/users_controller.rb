#Users may be either instructors or staff members
class UsersController < ApplicationController
  before_filter :require_user, only: :show

  def show
    @user = current_user
    #authorize! :show, @user
  end
end
