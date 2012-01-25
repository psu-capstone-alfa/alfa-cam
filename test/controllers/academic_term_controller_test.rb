require "minitest_helper"

describe AcademicTermController do

  # fixtures :all

  before do
    @academic_term = academic_terms(:one)
  end

  it "must get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:academic_terms)
  end

  it "must get new" do
    get :new
    assert_response :success
  end

  it "must create academic_term" do
    assert_difference('AcademicTerm.count') do
      post :create, academic_term: @academic_term.attributes
    end

    assert_redirected_to academic_term_path(assigns(:academic_term))
  end

  it "must show academic_term" do
    get :show, id: @academic_term.to_param
    assert_response :success
  end

  it "must get edit" do
    get :edit, id: @academic_term.to_param
    assert_response :success
  end

  it "must update academic_term" do
    put :update, id: @academic_term.to_param, academic_term: @academic_term.attributes
    assert_redirected_to academic_term_path(assigns(:academic_term))
  end

  it "must destroy academic_term" do
    assert_difference('AcademicTerm.count', -1) do
      delete :destroy, id: @academic_term.to_param
    end

    assert_redirected_to academic_terms_path
  end

end
