class OutcomesController < ApplicationController
  # GET /outcomes
  # GET /outcomes.json
  def index
    @outcomes = Outcome.all
    authorize! :read, @outcome

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @outcomes }
    end
  end

  # GET /outcomes/1
  # GET /outcomes/1.json
  def show
    @outcome = Outcome.find(params[:id])
    authorize! :read, @outcome

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @outcome }
    end
  end

  # GET /outcomes/new
  # GET /outcomes/new.json
  def new
    @outcome = Outcome.new
    authorize! :read, @outcome

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @outcome }
    end
  end

  # GET /outcomes/1/edit
  def edit
    @outcome = Outcome.find(params[:id])
    authorize! :edit, @outcome
  end

  # POST /outcomes
  # POST /outcomes.json
  def create
    @outcome = Outcome.new(params[:outcome])
    authorize! :create, @outcome

    respond_to do |format|
      if @outcome.save
        format.html { redirect_to @outcome,
          notice: 'Outcome was successfully created.' }
        format.json { render json: @outcome,
          status: :created, location: @outcome }
      else
        format.html { render action: "new" }
        format.json { render json: @outcome.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PUT /outcomes/1
  # PUT /outcomes/1.json
  def update
    @outcome = Outcome.find(params[:id])
    authorize! :update, @outcome

    respond_to do |format|
      if @outcome.update_attributes(params[:outcome])
        format.html { redirect_to @outcome,
          notice: 'Outcome was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @outcome.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outcomes/1
  # DELETE /outcomes/1.json
  def destroy
    @outcome = Outcome.find(params[:id])
    authorize! :destroy, @outcome
    @outcome.destroy

    respond_to do |format|
      format.html { redirect_to outcomes_url }
      format.json { head :ok }
    end
  end
end
