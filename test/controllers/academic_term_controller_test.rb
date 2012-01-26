require "minitest_helper"

describe AcademicTermsController do

  # fixtures :all
  
  it "must get index" do
    get :index
    must_respond_with :success
  end

  it "must get new" do
    get :new
    assert_response :success
  end

  it "must create academic_term" do
    assert_difference('AcademicTerm.count') do
      post :create, academic_term: {title: "Fall"} 
    end
    assert_redirected_to academic_term_path(assigns(:academic_term))
  end

  describe 'An existing academic term' do
    before do
      @at = AcademicTerm.create!(title: "A_Made_Up_Title")
    end
    it "must show academic_term" do
      get :show, id: @at.id
      assert_response :success
    end

    it "must get edit" do
      get :edit, id: @at.id
      assert_response :success
    end

    it "must update academic_term" do
      put :update, id: @at.id, academic_term: @at.attributes
      assert_redirected_to academic_term_path(assigns(:academic_term))
    end
    
  end

=begin
  it "must destroy academic_term" do
    @at = AcademicTerm.first
    assert_difference('AcademicTerm.count', -1) do
      delete :destroy, id: @academic_term.to_param
      delete :destroy, id: @at.id
    end
    assert_redirected_to academic_terms_path
  end
=end
end
