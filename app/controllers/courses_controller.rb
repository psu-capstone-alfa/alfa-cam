# Manage courses, scoped to a term by being a sub-resource
#
class CoursesController < ApplicationController
  respond_to :html, :json
  before_filter { @nav_section = :courses }
  before_filter { @term = AcademicTerm.find(params[:academic_term_id]) }
  before_filter { @nav_term = :courses }

  layout 'term'
  before_filter :require_user
  authorize_resource

  def index
    @courses = Course.all
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
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html {
          redirect_to [@term, @course],
            notice: 'Course was successfully created.'
        }
        format.json {
          render json: @course, status: :created, location: @course
        }
      else
        format.html { render action: "new" }
        format.json {
          render json: @course.errors, status: :unprocessable_entity
        }
      end
    end
  end

  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html {
          redirect_to [@term, @course],
            notice: 'Course was successfully updated.'
        }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json {
          render json: @course.errors, status: :unprocessable_entity
        }
      end
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to [@term, :courses] }
      format.json { head :ok }
    end
  end
end
