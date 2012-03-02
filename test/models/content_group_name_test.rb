require "minitest_helper"

describe ContentGroupNames do
  # fixtures :all

  before do
    @content_group_names = ContentGroupNames.new
  end

  it "must be valid" do
    @content_group_names.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
