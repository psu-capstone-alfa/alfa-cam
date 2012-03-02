require "minitest_helper"

describe Offerings::ReviewController do
  tests Offerings::ReviewController
  with_admin_session

  before do
    @offering = Factory :offering
    @args = { :offering_id => @offering.id }
  end

  describe "show action" do
    it "respond with success" do
      get :show, @args
      must_respond_with :success
      must_render_nothing_here
    end
  end

  describe "edit action" do
    it "must respond with sucess" do
      get :edit, @args
      must_respond_with :success
    end
  end
end

