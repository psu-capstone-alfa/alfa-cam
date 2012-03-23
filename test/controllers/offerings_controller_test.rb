require "minitest_helper"

describe OfferingsController do
  with_admin_session

  it "must get search" do
    get :search
    must_respond_with :success
  end


  it "must export offerings" do
    @request.env["HTTP_ACCEPT"] = "*/*"
    get :export, format: 'csv'
    must_respond_with :success
  end

  describe "in a term" do
    before do
      @term = Factory :academic_term
    end

    it "must index term's offerings" do
      get :index, academic_term_id: @term.id
      must_respond_with :success
    end

    it "must get new" do
      get :new, academic_term_id: @term.id
      must_respond_with :success
    end

    it "must create offering" do
      attributes = Factory(:offering).attributes
      attributes.delete(:id)
      assert_difference('Offering.count') do
        post :create, academic_term_id: @term.id, offering: attributes
      end
    end
  end

  it "must return a json representation of facets" do
    get :facets
    must_respond_with :success
  end


  describe 'An existing offering' do
    before do
      @offering = Factory(:offering)
    end

    it "must succeed with GET actions" do
      get :edit, id: @offering.id
      must_respond_with :success

      get :show, id: @offering.id
      must_respond_with :success
    end

    it "must update offering" do
      put :update, id: @offering.id, offering: @offering.attributes
      assert_redirected_to offering_path(assigns(:offering))
    end

    describe 'owned by user' do
      before do
        @offering.update_attribute :instructors, [@current_user]
      end

      describe 'summary page' do
        it "must redirect show when review not done" do
          get :show, id: @offering.id
          must_respond_with :redirect
        end

        it "must redirect show when importing not done" do
          @offering.update_attributes review_done: true
          get :show, id: @offering.id
          must_respond_with :redirect
        end

        it "must show success when importing done" do
          @offering.update_attributes review_done: true, importing_done: true
          get :show, id: @offering.id
          must_respond_with :success
        end
      end
    end
  end
end
