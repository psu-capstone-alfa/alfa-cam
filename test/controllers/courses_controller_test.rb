require "minitest_helper.rb"

describe CoursesController do
  # fixtures :all

  with_admin_session

  before do
    @term = Factory :term
  end

  it "should index available courses" do
    get :index, academic_term_id: @term
    must_respond_with :success
  end

  it 'must display new page' do
    get :new, academic_term_id: @term
    must_respond_with :success
  end

  it "should create course" do
    lambda do
      post :create, academic_term_id: @term, course: { dept_code: 'CS', course_num: '123', title: 'Testing' }
    end.must_change 'Course.count'
    must_redirect_to [@term, assigns(:course)]
  end

  describe 'an existing course' do
    before do
      @course = Course.create!(dept_code: 'CS', course_num: '123', title: 'Testing')
    end

    it 'must display show page' do
      get :show, academic_term_id: @term, id: @course
      must_respond_with :success
    end

    it 'must display edit page' do
      get :edit, academic_term_id: @term, id: @course
      must_respond_with :success
    end

    it 'should delete course' do
      lambda do
        delete :destroy, academic_term_id: @term, id: @course.id
      end.must_change 'Course.count', -1
      must_redirect_to [@term, :courses]
    end

    it 'should update title' do
      new_title = 'Updated Title'
      post :update,
        academic_term_id: @term,
        id: @course.id,
        course: { title: new_title }

      assigns(:course).title.must_equal new_title
      must_redirect_to [@term, assigns(:course)]
    end
  end

end

