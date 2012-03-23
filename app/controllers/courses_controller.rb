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
    @course = Course.new(params[:course])

    if @course.save
      flash[:success] = 'Course was successfully created.'
      redirect_to [@term, @course]
    else
      flash[:error] = @course.errors.full_messages.to_sentence
      render action: :new
    end
  end

  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html {
          redirect_to [@term, @course],
            success: 'Course was successfully updated.'
        }
      else
        format.html {
          flash[:error] = @course.errors.full_messages.to_sentence
          render action: "edit"
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
