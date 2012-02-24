class Offerings::BulksController < ApplicationController

  authorize_resource class: Offering
  before_filter { find_term }

  def edit
    @courses = @term.available_courses
    @instructors = User.with_role(:instructor).includes(offerings: :course)

    # TODO:eo extract this to the User model?
    # count # of occurences of each course ever taught by instructor
    @frequent_courses = @instructors.inject({}) do |hash, i|
      course_counts = i.offerings.inject({}) do |sums, o|
        sums[o.course] = (sums[o.course] || 0) + 1
        sums
      end
      hash[i.id] = {
        instructor: i,
        # TODO:eo parameterize the 5
        # only take the 5 most frequently taught courses
        courses: course_counts.sort_by {|_, count| -count }.map(&:first).first(5)
      }
      hash
    end
  end

private

  def find_term
    @term = AcademicTerm.find(params[:academic_term_id])
  end

end
