require 'minitest_helper'

describe OutcomeGroup do
  before do
    @orig_outcomes = (1..4).collect { Factory :outcome }
    @replace_outcomes = @orig_outcomes[1,2].map(&:dup)
    @replace_outcomes[0].title = 'New Title!'
    @replace_outcomes[1].title = 'Newer title!'

    @og1 = Factory :outcome_group, outcomes: @orig_outcomes
    @og2 = Factory :outcome_group, outcomes: []
  end

  it 'should not allow multiple outcomes with the same key' do
    @og1.must_be :valid?
    @og1.outcomes << @replace_outcomes
    @og1.wont_be :valid?
  end

  it 'should replace outcomes with the same key as existing outcomes' do
    @og2.outcomes << @og1.outcomes
    @og2.replace_outcomes(@replace_outcomes)
    
    @replace_outcomes.each do |replacement|
      @og2.outcomes.must_include replacement
      @og2.outcomes.wont_include(
        @orig_outcomes.find {|o| o.key == replacement.key }
      )
    end
  end

  describe 'outcome groups interacting with terms' do
    before do
      @t1 = AcademicTerm.new({title: 't1'})
      @t2 = AcademicTerm.new({title: 't2'})

      @t1.outcome_group = @og1
      @t1.save!
    end

    describe 'creating a new term/outcome group combo' do
      it 'should set initial_term on outcome_groups when created' do
        @t1.outcomes.must_equal @orig_outcomes
        @og1.initial_term.must_equal @t1
      end
    end
  end
end
