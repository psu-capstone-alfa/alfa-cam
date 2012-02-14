require "minitest_helper"

describe Offering do
  # fixtures :all

  before do
    #@co = Course.create!(:dept_code => 'CE', :course_num => '123', :title => 'Testing')
    #@at = AcademicTerm.create!(:title => "Fall 2020")
    @co = Course.first
    @at = AcademicTerm.first
  end
  
  after do 
    #@co.destroy
    #@at.destroy
  end

  it "must not be valid without a term id" do 
    @of = Offering.new(
      :course_id => @co.id,
      :section => "001",
      :crn => "47668",
      :location => "FAB 40-06"
    )
    assert_equal false, @of.valid?
    #@of.academic_term_id = @at.id
    @of.term_id = @at.id
    assert_equal true, @of.valid?
  end
  
  it "must not be valid without a course id" do 
    @of = Offering.new(
      :term_id => @at.id,
      :section => "001",
      :crn => "47668",
      :location => "FAB 40-06"
    )
    assert_equal false, @of.valid?
    @of.course_id = @co.id
    assert_equal true, @of.valid?
  end
  
  it "must export an array of export headings" do
    exportHeadings = Offering.exportHeadings
    exportHeadings.must_be_instance_of Array
    exportHeadings.size.must_be :>, 0
  end
  
  it "must export an array of export fields" do 
    @of = Offering.new(
      :course_id => @co.id,
      :term_id => @at.id,
      :section => "001",
      :crn => "47668",
      :location => "FAB 40-06"
    )
    exportFields = @of.exportFields
    exportFields.must_be_instance_of Array
    exportFields.size.must_be :>, 0
  end 

end
