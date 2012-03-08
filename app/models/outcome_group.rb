# Outcome groups are a set of outcomes active during some amount of terms
# Non-typo changes to outcomes should be reflected by cloning a group and
#  making changes there, to preserve older outcome sets
class OutcomeGroup < ActiveRecord::Base
  has_many :terms, class_name: 'AcademicTerm', inverse_of: :outcome_group

  has_many :outcomes

  def initial_term
    terms.order_oldest_first.last
  end

  def to_s
    title
  end
end
