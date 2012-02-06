require "minitest_helper"

describe OfferingsController do
  with_admin_session

  it "must get index" do
    get :index
    must_respond_with :success
  end
  
  it "must export offerings" do
    @request.env["HTTP_ACCEPT"] = "*/*"
    get :export
    must_respond_with :success
  end
  

=begin
  it "must get new" do
    get :new
    assert_response :success
  end

  it "must create offering" do
    assert_difference('Offering.count') do
      post :create, offering: {} 
    end
    assert_redirected_to offering_path(assigns(:offering))
  end

  describe 'An existing offering' do
  
    before do
      @of = Offering.create!()
    end
    
    it "must show offering" do
      get :show, id: @of.id
      assert_response :success
    end

    it "must get edit" do
      get :edit, id: @of.id
      assert_response :success
    end

    it "must update offering" do
      put :update, id: @of.id, offering: @of.attributes
      assert_redirected_to offering_path(assigns(:offering))
    end
    
  end
=end
end
