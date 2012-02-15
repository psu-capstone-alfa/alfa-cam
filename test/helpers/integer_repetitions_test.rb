require "minitest_helper"

describe Integer do
  describe 'repetitions method' do
    before do
      @int = 10
    end

    it 'must repeat the correct number of times' do
      @int.repetitions.length.must_equal @int
    end

    it 'must give nils with no arguments' do
      @int.repetitions.each {|itm| itm.must_be_nil }
    end

    it 'must copy item iff only argument' do
      item = 123
      @int.repetitions(item).each {|itm| itm.must_equal(item) }
    end

    it 'must call block once to build each item' do
      times = 0
      @int.repetitions { times += 1 }.must_equal (1..@int).to_a
      times.must_equal @int
    end

    it 'must warn when both block and item are given' do
      -> {
        @int.repetitions('yo') { 'hi' }
      }.must_output nil # nil means any output
    end

  end
end
