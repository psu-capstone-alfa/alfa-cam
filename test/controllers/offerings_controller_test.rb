require "minitest_helper"

describe OfferingsController do
  with_admin_session

  it "must get index" do
    get :index
    must_respond_with :success
  end

  it "must export offerings" do
    @request.env["HTTP_ACCEPT"] = "*/*"
    get :export, format: 'csv'
    must_respond_with :success
  end

  it "must get new" do
    skip("Need to debug this...")
    get :new
    assert_response :success
  end

  it "must create offering" do
    attributes = Factory(:offering).attributes
    attributes.delete(:id)
    assert_difference('Offering.count') do
      post :create, offering: attributes
    end
    assert_redirected_to offering_path(assigns(:offering))
  end

  describe 'An existing offering' do

    before do
      @offering = Factory(:offering)
    end

    it "must redirect show when review not done" do
      get :show, id: @offering.id
      assert_response :redirect
    end

    it "must redirect show when importing not done" do
      @offering.update_attributes review_done: true
      get :show, id: @offering.id
      assert_response :redirect
    end

    it "must show success when importing done" do
      @offering.update_attributes review_done: true, importing_done: true
      get :show, id: @offering.id
      assert_response :success
    end

    it "must get edit" do
      get :edit, id: @offering.id
      assert_response :success
    end

    it "must update offering" do
      put :update, id: @offering.id, offering: @offering.attributes
      assert_redirected_to offering_path(assigns(:offering))
    end
    
    it "must return a json representation of facets" do
      get :facets
      assert_response :success
    end

  end
end
