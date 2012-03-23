# Manage courses, scoped to a term by being a sub-resource
#
class CoursesController < ApplicationController
  respond_to :html, :json
  before_filter { @nav_section = :terms }
  before_filter { @term = AcademicTerm.find(params[:academic_term_id]) }
  before_filter { @nav_term = :courses }

  layout 'term'
  authorize_resource

  def index
    @courses = Course.available_during(@term).ordered
    respond_with @courses
  end

  def show
    @course = Course.find(params[:id])
    respond_with @course
  end

  def new
    @course = Course.new
    respond_with @course
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new
    @course.assign_attributes(params[:course])
    @course.created_term = @term

    if @course.save
      flash[:success] = 'Course was successfully created.'
      redirect_to [@term, :courses]
    else
      render action: :new
    end
  end

  def update
    @course = Course.find(params[:id])

    if @course.update_attributes(params[:course])
      flash[:success] = 'Course was successfully updated.'
      redirect_to [@term, :courses]
    else
      render action: :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])

    if @course.destroy
      flash[:success] = 'Course successfully destroyed'
      redirect_to [@term, :courses]
    else
      flash[:error] = 'Could not delete course'
      redirect_to [:edit, @term, @course]
    end
  end
end
