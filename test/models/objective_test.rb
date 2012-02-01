require "minitest_helper"

describe Objective do
  # fixtures :all

  before do
    @objective = Objective.new
  end

  it "must require a description" do
    @objective.wont_be :valid?
    @objective.description = "Development of mathematical techniques to solve engineering problems"
    @objective.must_be :valid?
  end
  
end
