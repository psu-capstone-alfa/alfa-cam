# Shared functionality for finding recent offerings of some specific
# offering's course
#
module Offerings::Recent
  private

    # Gets a specific offering choice if given,
    # otherwise get the current offering's course's
    # most recent completed offering
    def get_recent_offering_choice
      if params.has_key? :id
        @recent_offering_choice = Offering.find params[:id]
      end
      @recent_offering_choice ||= @offering.course.recent_offerings.first
    end

    # Builds options for a select box of recent offerings
    def get_recent_offering_choices
      @recent_options = @course.
        recent_offerings.
        map {|o| offering_option_format(o) }
      @my_recent_options = @course.
        recent_offerings_taught_by(current_user).
        map {|o| offering_option_format(o) }
    end

    def offering_option_format(offering)
      ["#{offering.term} : #{offering.instructors.join ','}", offering.id]
    end
end
