require "minitest_helper"

describe WelcomeController do
  with_admin_session

  describe "home action" do
    it "respond with success" do
      get :home
      must_respond_with :success
    end
  end
end

