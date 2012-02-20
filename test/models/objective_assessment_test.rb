require 'minitest_helper'

describe ObjectiveAssessment do
  before do
    @obj = Factory :objective_assessment
  end

  it 'must be associated with an assessment' do
    @obj.assessment = nil
    @obj.wont_be :valid?
  end

  it 'must be associated with an objective' do
    @obj.objective = nil
    @obj.wont_be :valid?
  end

  it 'must be associated with an offering' do
    @obj.assessment = Assessment.new
    @obj.wont_be :valid?
  end

  it 'wont be valid assessing an unrelated objective' do
    @obj.objective = Factory :objective
    @obj.wont_be :valid?
  end


end
