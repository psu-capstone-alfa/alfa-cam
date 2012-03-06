require "minitest_helper"

describe Offering do
  before do
    @offering = Factory(:offering)
  end

  describe "validations" do
    it "must not be valid without a term id" do
      @offering.term_id = nil
      @offering.wont_be :valid?
    end

    it "must not be valid without a course id" do
      @offering.course_id = nil
      @offering.wont_be :valid?
    end
  end

  describe "instructor relationships" do
    it "must know who its instructors are" do
      i1, i2 = Factory(:user), Factory(:user)
      offering = Factory(:offering)
      offering.instructors << i1
      assert offering.taught_by? i1
      assert !offering.taught_by?(i2)
    end
  end

  describe "content and content groups" do
    before do
      @term = Factory(:academic_term)
      @content_group_names = 4.repetitions { Factory(:content_group_name) }
    end

    it "must be able to build active content groups" do
      @offering.prepare_content_groups
      @offering.content_groups.length.must_equal @content_group_names.length
      @offering.content_groups.map(&:content_group_name).must_equal @content_group_names
    end
  end

  describe "exporting" do
    it "must export an array of export headings" do
      export_headings = Offering.export_headings
      export_headings.must_be_instance_of Array
      export_headings.wont_equal []
    end

    it "must export an array of export fields" do
      @offering = Factory(:offering)
      export_fields = @offering.export_fields
      export_fields.must_be_instance_of Array
      export_fields.size.must_be :>, 0
    end
  end
end
