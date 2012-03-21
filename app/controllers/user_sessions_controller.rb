# Provides pages for logging in and out users
#
class UserSessionsController < ApplicationController
  skip_before_filter :require_user
  skip_authorization_check

  def new
    redirect_to profile_path and return if current_user_session
    @nav_section = :login
    @user_session = UserSession.new
    @users = User.all
  end

  def create
    login_type = case params[:login_type]
      when 'ldap'
        :ldap
      when 'local'
        :local
      when 'skip' # TODO:rs remove authentication avoidance in production? :D
        :skip
      else
        :local
    end

    @session = UserSession.new(params[:user_session], login_type: login_type)

    if @session.save!
      flash[:success] = "Login successful"
      redirect_back_or_default home_path
    else
      flash[:alert] = "Invalid login"
      render :action => :new
    end
  end

  def delete
    @nav_section = :logout
  end

  def destroy
    redirect_to login_path and return unless current_user_session
    clear_stored_location
    current_user_session.destroy
    flash[:success] = 'Logout successful'
    redirect_to login_path
  end
end
