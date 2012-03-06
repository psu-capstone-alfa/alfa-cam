require "minitest_helper"

describe DashboardController do
  tests DashboardController

  before do
    Factory :term
  end

  describe "any user" do
    with_user(Factory :user, roles: [:reviewer, :instructor, :staff, :admin])

    [:reviewer, :instructor, :staff, :admin].each do |role|
      describe "#{role} dashboard" do
        it "must respond with success" do
          get role
          must_respond_with :success
        end
      end
    end

  end

  describe "reviewer" do
    with_user Factory :user, roles: [:reviewer]

    describe "home" do
      it "must redirect to reviewer dashboard" do
        get :home
        must_redirect_to home_reviewer_path
      end
    end
  end

  describe "instructor" do
    with_user(Factory :instructor)

    describe "home" do
      it "must redirect to instructor dashboard" do
        get :home
        must_redirect_to home_instructor_path
      end
    end
  end

  describe "staff" do
    with_user Factory :user, roles: [:staff]

    describe "home" do
      it "must redirect to staff dashboard" do
        get :home
        must_redirect_to home_staff_path
      end
    end

    describe "second dashboard" do
      it "must be success" do
        get :staff2
      end
    end
  end

  describe "admin" do
    with_user Factory :admin

    describe "home" do
      it "must redirect to admin dashboard" do
        get :home
        must_redirect_to home_admin_path
      end
    end
  end

end

