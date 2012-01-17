require "minitest_helper"

#class CourseReplacementTest < MiniTest::Rails::Model
describe CourseReplacement do
  it 'should work' do
    c1 = Course.create
    c2 = Course.create
    c1.replaces<< c2
    
    c1.replaces.must_include c2
    c1.replaced_with.wont_include c2
    
    c2.replaces.wont_include c1
    c2.replaced_with.must_include c1
  end
end
