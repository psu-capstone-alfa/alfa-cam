require "minitest_helper"

describe Objective do
  # fixtures :all

  before do
    @objective = Factory :objective
  end

  it "must require a description" do
    @objective.description = nil
    @objective.wont_be :valid?
    @objective.description = "Development of mathematical techniques to solve engineering problems"
    @objective.must_be :valid?
  end

  describe 'with multiple mappings' do
    before do
      @mappings = 3.repetitions { Factory :mapping}
      @outcomes = @mappings.collect(&:outcome)
    end

    it "must update mapped_outcomes association" do
      @objective.mappings = @mappings
      @objective.save!
      @objective.mapped_outcomes.must_equal @outcomes
    end
  end

  describe 'mapping nested attributes' do
    before do
      @attrs = Factory.build(:mapping).attributes
    end

    it "must create new mappings" do
      -> {
        @objective.mappings_attributes = @attrs
        @objective.save!
      }.must_change '@objective.mappings.count', 1
      @objective.mapped_outcome_ids.must_include @attrs['outcome_id']
    end
  end
end
