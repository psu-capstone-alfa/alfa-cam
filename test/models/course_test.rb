require "minitest_helper"

#class CourseTest < MiniTest::Rails::Model
describe Course do
  before do
    @course = Course.new
  end

  it "must be invalid without department, number, and title" do
    @course.wont_be :valid?

    @course[:dept_code] = 'CS'
    @course.wont_be :valid?

    @course[:course_num] = '123'
    @course.wont_be :valid?

    @course[:title] = "Writing Unit Tests"

    @course.must_be :valid?
  end

end
