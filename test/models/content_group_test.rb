require 'minitest_helper'

describe ContentGroup do

  describe 'content association' do
    before do
      @content_group = Factory :content_group
    end

    it "should build new content with correct mappings" do
      content = @content_group.content.build_with_mappings(
          @content_group.outcomes)
      content.mappings.map(&:outcome_id).must_equal(
          @content_group.outcomes.map(&:id))
    end
  end

  describe 'nested attributes' do
    it 'should reject an empty row of content and mappings' do
      empty_attributes = {
        'title' => '',
        'mappings_attributes' => {
          1 => {'value' => ''},
          2 => {'value' => ''}
        }
      }

      assert ContentGroup::REJECT.call(empty_attributes)
    end
  end
end
