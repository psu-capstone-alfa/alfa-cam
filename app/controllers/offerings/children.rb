# Common functionality among Offerings:: sub controllers
class Offerings::Children < ApplicationController
  before_filter :require_user
  authorize_resource class: Offering

  before_filter { @nav_section = :offerings }
  before_filter :find_resource

  before_filter :redirect_before_import
  before_filter :redirect_to_edit, only: [:show]
  before_filter :redirect_from_unready

private

  def find_resource
    @offering = Offering.find params[:offering_id]
    @course = @offering.course
  end

  def redirect_before_import
    return if current_user.is? :admin

    case controller_name
    when 'importing'
      return if @offering.is_ready?(:importing)
    when 'review'
      return if @offering.is_ready?(:review)
    end

    [:review, :importing].each do |stage|
      render "offerings/not_ready" and return if @offering.is_ready?(stage)
    end
  end

  def redirect_to_edit
    if @offering.taught_by? current_user and
        not @offering.completed? and
        @offering.is_ready? controller_name and
        not @offering.is_complete? controller_name
      redirect_to action: :edit
    end
  end

  def redirect_from_unready
    if @offering.taught_by? current_user and
        not @offering.is_ready? controller_name
      render "offerings/not_ready" and return
    end
  end
end
