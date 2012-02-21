require "minitest_helper"

describe UsersController do
  with_admin_session

  it "must get index" do
    get :index
    assert_response :success
    assigns(:users).wont_be :nil?
  end

  it "must get new" do
    get :new
    assert_response :success
  end

  it "must create user" do
    @user = Factory.build :user
    assert_difference('User.count') do
      post :create, user: @user.attributes
    end

    assert_redirected_to user_path(assigns(:user))
  end

  describe 'with existing user' do
    before do
      @user = Factory :user
    end

    it "must show user" do
      get :show, id: @user.to_param
      assert_response :success
    end

    it "must get edit" do
      get :edit, id: @user.to_param
      assert_response :success
    end

    it "must update user" do
      put :update, id: @user.to_param, user: @user.attributes
      assert_redirected_to user_path(assigns(:user))
    end

    it "must destroy user" do
      assert_difference('User.count', -1) do
        delete :destroy, id: @user.to_param
      end

      assert_redirected_to users_path
    end
  end
end
