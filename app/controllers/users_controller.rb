# Manage user accounts and details
#
class UsersController < ApplicationController
  before_filter :require_user
  authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user != current_user
      @user.destroy
      redirect_to users_url
    else
      redirect_to :back, alert: "User cannot delete self"
    end
  end

  def profile
    @nav_section = :profile
    @user = current_user
    render :show
  end
end
