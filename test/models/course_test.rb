require "minitest_helper"

describe Course do
  before do
    @course = Factory :course
  end

  it 'must be invalid without department' do
    @course.dept_code = nil
    @course.wont_be :valid?
  end

  it 'wont be valid without course number' do
    @course.course_num = nil
    @course.wont_be :valid?
  end

  it 'wont be valid without title' do
    @course.title = nil
    @course.wont_be :valid?
  end

  it 'wont be valid without associated creation term' do
    @course.created_term = nil
    @course.wont_be :valid?
  end

  describe 'destruction restrictions' do
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
