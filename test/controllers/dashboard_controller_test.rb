require "minitest_helper"

describe DashboardController do
  # fixtures :all

  describe "home action" do
    it "respond with success" do
      get :home
      must_respond_with :success
    end
  end
  describe "instructor action" do
    it "respond with success" do
      get :instructor
      must_respond_with :success
    end
  end
  describe "staff action" do
    it "respond with success" do
      get :staff
      must_respond_with :success
    end
  end
end

