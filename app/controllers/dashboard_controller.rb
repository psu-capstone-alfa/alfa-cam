# Manages viewing dashboard of instructor and staff
#
class DashboardController < ApplicationController
  respond_to :html, :json
  skip_authorization_check

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
    @offerings_by_term = @instructor.
      offerings.
      term_order.
      order_by_status.
      group_by(&:term)
  end

  def staff
    @staff = current_user
    @term = AcademicTerm.current
    @offerings = Offering.
      where(term_id: @term).
      course_order.
      with_instructors.
      all
  end

  def staff2
    @term = AcademicTerm.current

    @redInstructors = User.
      with_role(:instructor).
      with_uncomplete_offerings_during_or_before(@term)

    @greenInstructors = User.
      instructors.
      with_complete_offerings_during(@term) -
      @redInstructors

    @redInstructors.map! do |instructor|
      offerings = instructor.
        offerings.
        uncompleted.
        before_or_during(@term)
      {
        :instructor => instructor,
        :uncomplete => offerings
      }
    end
  end

  def admin
  end

  def reviewer
  end


end
