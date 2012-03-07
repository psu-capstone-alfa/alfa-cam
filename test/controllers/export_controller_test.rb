require "minitest_helper"

describe ExportController do
  # fixtures :all

  describe "offerings action" do
    it "respond with success" do
      get :offerings
      must_respond_with :success
    end
  end
end

