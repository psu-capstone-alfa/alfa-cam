require 'minitest_helper'

describe User do
  before do
    @instructor = Factory(:instructor)
  end

  describe "instructor users" do
    before do
      # TaughtOrNot.com
      @taught = Factory(:offering)
      @not = Factory(:offering)

      @taught.instructors << @instructor
    end

    it "should know if they teach an offering" do
      assert @instructor.teaches?(@taught)
      assert !@instructor.teaches?(@not)
    end
    
    it "must return an array of instructor facets" do 
      facets = User.with_role(:instructor).facets
      assert_instance_of Array, facets
    end
    
  end
end
