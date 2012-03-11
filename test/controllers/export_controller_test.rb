require "minitest_helper"

describe ExportController do
  tests ExportController
  with_admin_session

  describe "search action" do
    it "respond with success" do
      get :search
      must_respond_with :success
    end
  end
end

