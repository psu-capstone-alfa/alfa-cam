# Handles bulk creation of offerings for a term, for use by staff/admin
# to easily create lots and lots of offerings.
class Offerings::BulksController < ApplicationController

  authorize_resource class: Offering
  before_filter { find_term }

  def edit
    @courses = @term.available_courses
    # eager loads... a lot. needs performance test w/ large # of instructors etc
    # should scope offerings to courses available in this term
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

    # build all existing/potential offerings for each instructor/course combo
    # this is currently EXPENSIVE: needs |instructor| * |course| queries
    # TODO:eo performance test w/ new seeds
    @offerings = @instructors.inject({}) do |offerings, instructor|
      offerings[instructor] = @courses.inject({}) do |instructor_offerings, course|
        # find any offerings that are taught by this instructor
        # and ONLY this instructor -- bulk UI does not handle co-teachings
        # TODO: somehow indicate the offerings instructors are co-teaching?
        offering = @term.offerings.joins(:teachings).where(course_id: course.id, teachings: {user_id: instructor.id}).where('(select count(*) from teachings t join offerings o where t.offering_id = o.id and o.course_id = ? and o.term_id = ?) >= 1', course.id, @term.id).first
        offering ||= @term.offerings.build(course: course, teachings_attributes: [{user_id: instructor.id}])

        instructor_offerings[course] = offering
        instructor_offerings
      end
      offerings
    end
  end

  def update
    @term.attributes = params[:academic_term]
    if @term.save
      redirect_to @term, notice: 'Course offerings created'
    else
      edit
      render action: 'edit'
    end
  end

private

  def find_term
    @term = AcademicTerm.find(params[:academic_term_id])
  end

end
