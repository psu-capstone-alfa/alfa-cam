# Manages viewing dashboard of instructor and staff

class DashboardController < ApplicationController
  respond_to :html, :json
  def home
    @user = current_user
    if @user.is? :instructor
      redirect_to home_instructor_path
    elsif @user.is? :staff
      redirect_to home_staff_path
    elsif @user.is? :admin
      redirect_to home_admin_path
    elsif @user.is? :reviewer
      redirect_to home_reviewer_path  
    end
  end

  def instructor
    @instructor = current_user
    @offerings_by_term = @instructor.offerings.group_by(&:term)
  end

  def staff
    @staff = current_user
    @offerings = Offering.all
  end
  
  def admin 
  end
  
  def reviewer
  end

end
