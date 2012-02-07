require 'minitest_helper'

describe Mapping do
  describe 'validations' do
    it 'should only accept values of 0..10' do
      mapping = Mapping.new
      mapping.wont_be :valid?

      mapping.value = -3
      mapping.wont_be :valid?

      mapping.value = 10000
      mapping.wont_be :valid?

      mapping.value = 1
      mapping.must_be :valid?
    end
  end
end
