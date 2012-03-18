# Manage user accounts and details
#
class UsersController < ApplicationController
  before_filter { @nav_section = :users }
  load_resource except: :profile
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
      flash[:success] = 'User successfully created.'
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = 'User successfully updated.'
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user != current_user
      @user.destroy
      redirect_to users_url
    else
      flash[:alert] = "User cannot delete self"
      redirect_to :back
    end
  end

  def profile
    @nav_section = :profile
    @user = current_user
    render :show
  end
end
