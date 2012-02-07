require "minitest_helper"

describe WelcomeController do
  # fixtures :all

  describe "home action" do
    it "respond with success" do
      get :home
      must_respond_with :success
    end
  end
end

