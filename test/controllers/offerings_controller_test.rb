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

    it "must show offering" do
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

  end
end
