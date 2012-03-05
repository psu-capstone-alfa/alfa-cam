require "minitest_helper"

describe OutcomesController do
  with_admin_session

  it "must have index page" do
    get :index
    must_respond_with :success
  end

  describe "with existing outcome" do
    before do
      @outcome = Factory :outcome
    end

    it "must have a show page" do
      get :show, :id => @outcome.id
      must_respond_with :success
    end

    it "must have an edit page" do
      get :edit, :id => @outcome.id
      must_respond_with :success
    end

    it "must be destroyable" do
      skip
      delete :destroy, :id => @outcome.id
      must_respond_with :success
    end
  end


  it 'must have new page' do
    get :new
    must_respond_with :success
  end

end
