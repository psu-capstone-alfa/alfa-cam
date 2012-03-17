#controller : sending notification from the system to the users: instructors
class NotificationController < ApplicationController
  before_filter :require_user

  def home
  end

  def remind
    @currInst = User.find(params[:id])
    UserMailer.send_red_reminder(@currInst).deliver
  end

  def start_term
    @term = AcademicTerm.find(params[:term])
    @instructors = @term.instructors
    @instructors.each do |instructor|
      UserMailer.send_start_term_notice(term, instructor).deliver
    end
  end
end
