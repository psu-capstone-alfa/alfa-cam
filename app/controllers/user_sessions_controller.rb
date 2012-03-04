# Provides pages for logging in and out users
#
class UserSessionsController < ApplicationController
  before_filter :require_no_user, only: [:new, :create]
  before_filter :require_user, except: [:new, :create]
  skip_authorization_check

  def new
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
      redirect_back_or_default profile_path
    else
      flash[:alert] = "Invalid login"
      render :action => :new
    end
  end

  def delete
    @nav_section = :logout
  end

  def destroy
    current_user_session.destroy
    flash[:success] = 'Logout successful'
    redirect_to login_path
  end
end
