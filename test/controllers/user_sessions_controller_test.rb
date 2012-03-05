require "minitest_helper"

describe UserSessionsController do
  tests UserSessionsController

  describe "login page" do
    it "must work" do
      get :new
      must_respond_with :success
    end
  end

end
