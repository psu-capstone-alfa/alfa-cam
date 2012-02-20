require "minitest_helper"

describe Offerings::ObjectivesController do
  with_admin_session

  before do
    @offering = Factory :offering
    @args = { :offering_id => @offering.id }
  end

  describe "summary action" do
    it "respond with success" do
      get :summary, @args
      must_respond_with :success
      must_render_nothing_here
    end
  end
  describe "edit action" do
    it "respond with success" do
      get :edit, @args
      must_respond_with :success
    end
  end
  describe "show action" do
    it "respond with success" do
      get :show, @args
      must_respond_with :success
      must_render_nothing_here
    end
  end
end

