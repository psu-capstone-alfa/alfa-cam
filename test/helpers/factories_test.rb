require "minitest_helper"

describe 'Factories' do
  @factories = Miniskirt.class_variable_get :@@attrs

  @factories.each_key do |fact|
    it "must build valid #{fact}" do
      Factory.build(fact).must_be :valid?
    end
  end
end

