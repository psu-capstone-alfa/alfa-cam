# Provides viewing and management of terms to users
#
class AcademicTermsController < ApplicationController
  respond_to :html, :json
  before_filter { @nav_section = :terms }
  before_filter only: [:show, :edit] { @nav_term = :details }

  layout 'term', except: [:index, :new]
  authorize_resource

  def index
    @term = @academic_terms = AcademicTerm.all
    respond_with @academic_terms, layout: 'application'
  end

  def show
    @term = @academic_term = AcademicTerm.find(params[:id])
    respond_with @academic_term
  end

  def new
    @term = @academic_term = AcademicTerm.new
    respond_with @academic_term, layout: 'application'
  end

  def edit
    @term = @academic_term = AcademicTerm.find(params[:id])
  end

  def create
    @academic_term = AcademicTerm.new(params[:academic_term])

    respond_to do |format|
      if @academic_term.save
        format.html {
          redirect_to @academic_term,
          success: 'Academic term was successfully created.'
        }
      else
        format.html {
          flash[:error] = @academic_term.errors.full_messages.to_sentence
          render action: "new"
        }
      end
    end
  end

  def update
    @academic_term = AcademicTerm.find(params[:id])

    respond_to do |format|
      if @academic_term.update_attributes(params[:academic_term])
        format.html {
          redirect_to @academic_term,
          notice: 'Academic term was successfully updated.'
        }
      else
        format.html {
          flash[:error] = @academic_term.errors.full_messages.to_sentence
          render action: "edit"
        }
      end
    end
  end

  def destroy
    @academic_term = AcademicTerm.find(params[:id])
    @academic_term.destroy

    respond_to do |format|
      format.html { redirect_to academic_terms_url }
      format.json { head :ok }
    end
  end

  def bulk_courses
    @instructors = User.all  #FIXME:cd for now all users are returned
    @courses = Course.all
    @academic_term = AcademicTerm.find(params[:id])
    @new_offering = Offering.new term: @academic_term

    respond_to do |format|
      format.html # bulk_courses.html.erb
      format.json { render json: @instructors }
      format.json { render json: @courses }
      format.json { render json: @academic_term.offerings }
    end
  end

  def pre_term_notification
    @academic_term.instructors.include(:offerings).each do |instructor|
      UserMailer.send_start_term_notice(@academic_term,instructor).deliver
    end
  end
end
