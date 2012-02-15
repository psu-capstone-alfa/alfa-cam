require "minitest_helper"

describe OutcomesController do
  with_admin_session

  it "must have index page" do
    get :index
    must_respond_with :success
  end

  it 'must have new page' do
    get :new
    must_respond_with :success
  end

end
