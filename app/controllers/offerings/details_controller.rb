# Second stage of an offering. Collects syllabus details about an offering.
#
class Offerings::DetailsController < Offerings::Children
  layout 'offering'

  before_filter { @nav_offering = :details }
  before_filter :load_layout_variables

  def edit
  end

  def show
  end

  def update
    if @offering.update_attributes(params[:offering])
      flash[:success] = case
        when params[:offering][:details_done]
          'Details complete'
        else
          'Details saved'
      end
      redirect_to action: :edit
    else
      render :edit
    end
  end

  private
    def load_layout_variables
      @course = @offering.course
      @term = @offering.term
      @instructors = @offering.instructors
      @outcomes = @offering.outcomes
    end

  end
