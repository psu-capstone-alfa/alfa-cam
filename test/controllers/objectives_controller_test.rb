require "minitest_helper"

describe ObjectivesController do

  # fixtures :all

=begin
  create_table "offerings", :force => true do |t| 
    t.integer  "course_id"
    t.integer  "academic_term_id"
    t.string   "section"
    t.string   "crn"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
=end  

  before do
    @academic_term = AcademicTerm.first
    @course = Course.create!(dept_code: 'CS', course_num: '123', title: 'Testing')
    @offering = Offering.create!(course_id: @course.id, academic_term_id: @academic_term.id)
    @objective = Objective.create(offering_id: @offering.id, description: "Development of mathematical techniques to solve engineering problems")
  end

  it "must get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:objectives)
  end

  it "must get new" do
    get :new
    assert_response :success
  end

  it "must create objective" do
    assert_difference('Objective.count') do
      post :create, objective: @objective.attributes
    end

    assert_redirected_to objective_path(assigns(:objective))
  end

  it "must show objective" do
    get :show, id: @objective.to_param
    assert_response :success
  end

  it "must get edit" do
    get :edit, id: @objective.to_param
    assert_response :success
  end

  it "must update objective" do
    put :update, id: @objective.to_param, objective: @objective.attributes
    assert_redirected_to objective_path(assigns(:objective))
  end

  it "must destroy objective" do
    assert_difference('Objective.count', -1) do
      delete :destroy, id: @objective.to_param
    end

    assert_redirected_to objectives_path
  end

end
