require "minitest_helper"

describe Teaching do
  describe "a basic assocation" do
    before do
      @offering = Factory :offering
      @instructor = Factory :instructor
    end

    describe 'Offering' do
      it "must associate an instructor when added to their offerings" do
        @instructor.offerings << @offering
        @offering.instructors.must_include @instructor
      end
    end

    describe 'Instructor' do
      it "must associate an offering when added to their instructors" do
        @offering.instructors << @instructor
        @instructor.offerings.must_include @offering
      end
    end
  end
end
