class UserSessionsController < ApplicationController
  before_filter :require_no_user, only: [:new, :create]
  before_filter :require_user, except: [:new, :create]

  def new
    @user_session = UserSession.new
    @users = User.all
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    # TODO: Remove after LDAP authenticating
    @user_session.password = 'noth1n@here'

    if @user_session.save!
      flash[:notice] = "Login successful"
      redirect_back_or_default profile_path
    else
      flash[:notice] = "Invalid login"
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = 'Logout successful'
    redirect_back_or_default login_path
  end
end
