require "minitest_helper.rb"

describe CoursesController do
  # fixtures :all

  with_admin_session

  it "should index available courses" do
    get :index
    must_respond_with :success
  end

  it "should create course" do
    lambda do
      post :create, course: { dept_code: 'CS', course_num: '123', title: 'Testing' }
    end.must_change 'Course.count'
    must_redirect_to course_path(assigns(:course))
  end

  describe 'an existing course' do
    before do
      @course = Course.create!(dept_code: 'CS', course_num: '123', title: 'Testing')
    end

    it 'should delete course' do
      lambda do
        delete :destroy, id: @course.id
      end.must_change 'Course.count', -1
      must_redirect_to courses_path
    end

    it 'should update title' do
      new_title = 'Updated Title'
      post :update, id: @course.id, course: { title: new_title }

      assigns(:course).title.must_equal new_title
      must_redirect_to course_path(assigns(:course))
    end
  end

end

