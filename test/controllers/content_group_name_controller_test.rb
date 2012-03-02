require "minitest_helper"

describe ContentGroupNameController do

  # fixtures :all

  before do
    @content_group_name = content_group_names(:one)
  end

  it "must get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:content_group_names)
  end

  it "must get new" do
    get :new
    assert_response :success
  end

  it "must create content_group_name" do
    assert_difference('ContentGroupName.count') do
      post :create, content_group_name: @content_group_name.attributes
    end

    assert_redirected_to content_group_name_path(assigns(:content_group_name))
  end

  it "must show content_group_name" do
    get :show, id: @content_group_name.to_param
    assert_response :success
  end

  it "must get edit" do
    get :edit, id: @content_group_name.to_param
    assert_response :success
  end

  it "must update content_group_name" do
    put :update, id: @content_group_name.to_param, content_group_name: @content_group_name.attributes
    assert_redirected_to content_group_name_path(assigns(:content_group_name))
  end

  it "must destroy content_group_name" do
    assert_difference('ContentGroupName.count', -1) do
      delete :destroy, id: @content_group_name.to_param
    end

    assert_redirected_to content_group_names_path
  end

end
