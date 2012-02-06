# Provides viewing and management of terms to users
#
class AcademicTermsController < ApplicationController
  respond_to :html, :json

  def index
    @academic_terms = AcademicTerm.all
    authorize! :index, AcademicTerm
    respond_with @academic_terms
  end

  def show
    @academic_term = AcademicTerm.find(params[:id])
    authorize! :show, @academic_term
    respond_with @academic_term
  end

  def new
    @academic_term = AcademicTerm.new
    authorize! :new, @academic_term
    respond_with @academic_term
  end

  def edit
    @academic_term = AcademicTerm.find(params[:id])
    authorize! :edit, @academic_term
  end

  def create
    @academic_term = AcademicTerm.new(params[:academic_term])
    authorize! :create, @academic_Term

    respond_to do |format|
      if @academic_term.save
        format.html {
          redirect_to @academic_term,
          notice: 'Academic term was successfully created.'
        }
        format.json {
          render json: @academic_term,
          status: :created,
          location: @academic_term
        }
      else
        format.html { render action: "new" }
        format.json {
          render json: @academic_term.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  def update
    @academic_term = AcademicTerm.find(params[:id])
    authorize! :update, @academic_Term

    respond_to do |format|
      if @academic_term.update_attributes(params[:academic_term])
        format.html {
          redirect_to @academic_term,
          notice: 'Academic term was successfully updated.'
        }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json {
          render json: @academic_term.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  def destroy
    @academic_term = AcademicTerm.find(params[:id])
    authorize! :destroy, @academic_term
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
end
