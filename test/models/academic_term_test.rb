require "minitest_helper"

describe AcademicTerm do
  # fixtures :all

  before do
    @term = AcademicTerm.new
  end

  it "must contain a title" do 
    @term.wont_be :valid?
    @term.title = "test"
    @term.must_be :valid?
  end

  describe 'destruction restrictions' do
    before do
      @offering = Factory :offering
    end

    it 'must be destroyed when not related to offerings' do
      @term.offerings = []
      @term.destroy.wont_equal false
    end

    it 'must not be destroyed when related to offerings' do
      @term.offerings = [@offering]
      @term.destroy.must_equal false
    end
    
    it "must return an array of facets" do 
      assert_instance_of Array, AcademicTerm.facets
    end
    
  end
end
