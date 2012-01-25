require "minitest_helper"

describe AcademicTerm do
  # fixtures :all

  before do
    @academic_term = AcademicTerm.new
  end

  it "must be valid" do
    @academic_term.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
