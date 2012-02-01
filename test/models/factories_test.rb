require "minitest_helper"

describe 'Factories' do
  @factories = [:course, :academic_term, :offering, :admin]

  @factories.each do |fact|
    it "must build valid #{fact}" do
      Factory.build(fact).must_be :valid?
    end
  end
end

