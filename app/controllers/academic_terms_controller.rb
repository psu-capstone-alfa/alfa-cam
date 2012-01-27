class AcademicTermsController < ApplicationController
  # GET /academic_terms
  # GET /academic_terms.json
  def index
    @academic_terms = AcademicTerm.all
    authorize! :index, AcademicTerm

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @academic_terms }
    end
  end

  # GET /academic_terms/1
  # GET /academic_terms/1.json
  def show
    @academic_term = AcademicTerm.find(params[:id])
    authorize! :show, @academic_term

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @academic_term }
    end
  end

  # GET /academic_terms/new
  # GET /academic_terms/new.json
  def new
    @academic_term = AcademicTerm.new
    authorize! :new, @academic_term

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @academic_term }
    end
  end

  # GET /academic_terms/1/edit
  def edit
    @academic_term = AcademicTerm.find(params[:id])
    authorize! :edit, @academic_term
  end

  # POST /academic_terms
  # POST /academic_terms.json
  def create
    @academic_term = AcademicTerm.new(params[:academic_term])
    authorize! :create, @academic_Term

    respond_to do |format|
      if @academic_term.save
        format.html { redirect_to @academic_term, notice: 'Academic term was successfully created.' }
        format.json { render json: @academic_term, status: :created, location: @academic_term }
      else
        format.html { render action: "new" }
        format.json { render json: @academic_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /academic_terms/1
  # PUT /academic_terms/1.json
  def update
    @academic_term = AcademicTerm.find(params[:id])
    authorize! :update, @academic_Term

    respond_to do |format|
      if @academic_term.update_attributes(params[:academic_term])
        format.html { redirect_to @academic_term, notice: 'Academic term was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @academic_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /academic_terms/1
  # DELETE /academic_terms/1.json
  def destroy
    @academic_term = AcademicTerm.find(params[:id])
    authorize! :destroy, @academic_term
    @academic_term.destroy

    respond_to do |format|
      format.html { redirect_to academic_terms_url }
      format.json { head :ok }
    end
  end
end
