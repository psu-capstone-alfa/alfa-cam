require "minitest_helper"

describe AcademicTerm do
  # fixtures :all

  before do
    @academic_term = AcademicTerm.new
  end

  it "must contain a title" do 
    assert_equal false, @academic_term.valid?
    @academic_term.title = "test"
    assert_equal true, @academic_term.valid?
  end
end
