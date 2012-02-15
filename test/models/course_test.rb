require "minitest_helper"

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

  describe 'destruction restrictions' do
    before do
      @course = Factory :course
    end

    it 'must be destroyed when not related to offerings' do
      @course.offerings = []
      @course.destroy.wont_equal false
    end

    it 'must not be destroyed when related to offerings' do
      @course.offerings = [(Factory :offering)]
      @course.destroy.must_equal false
    end
  end

end
