require "minitest_helper"

describe Assessment do
  before do
    @assessment = Factory :assessment
  end

  it 'wont be valid without an offering' do
    @assessment.offering = nil
    @assessment.wont_be :valid?
  end
end
