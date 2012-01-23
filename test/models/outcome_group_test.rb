require 'minitest_helper'

describe OutcomeGroup do
  before do
    @original_outcomes = 
      Outcome.create!([
                       {key: 'A', title: 'A', description: 'A'},
                       {key: 'B', title: 'B', description: 'B'},
                       {key: 'C', title: 'C', description: 'C'},
                      ])

    @replacement_outcomes = 
      Outcome.create!([
                       {key: 'A', title: 'A1', description: 'A1'},
                       {key: 'B', title: 'B1', description: 'B1'}
                      ])
    
    @og1 = OutcomeGroup.new({title: 'og1'})
    @og2 = OutcomeGroup.new({title: 'og2'})

    @og1.outcomes << @original_outcomes
  end

  it 'should not allow multiple outcomes with the same key' do
    @og1.must_be :valid?
    @og1.outcomes << @replacement_outcomes
    @og1.wont_be :valid?
  end

  it 'should replace outcomes with the same key as existing outcomes' do
    @og2.outcomes << @og1.outcomes
    @og2.replace_outcomes(@replacement_outcomes)
    
    @replacement_outcomes.each do |replacement|
      @og2.outcomes.must_include replacement
      @og2.outcomes.wont_include @original_outcomes.find {|o| o.key == replacement.key }
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
        @t1.outcomes.must_equal @original_outcomes
        @og1.initial_term.must_equal @t1
      end
    end
  end
end
