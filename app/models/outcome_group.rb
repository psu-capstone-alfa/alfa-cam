# Outcome groups are a set of outcomes active during some amount of terms
# Non-typo changes to outcomes should be reflected by cloning a group and
#  making changes there, to preserve older outcome sets
class OutcomeGroup < ActiveRecord::Base
  has_many :terms, class_name: 'AcademicTerm', inverse_of: :outcome_group
  has_many :outcome_mappings, include: :outcome, inverse_of: :outcome_group
  has_many :outcomes, through: :outcome_mappings

  validate :ensure_outcome_key_uniqueness

  # TODO:eo this would depend on terms being ordered by date
  # so we should probably add an order to the terms association
  def initial_term
    terms.first
  end

  # TODO:eo can this behavior be added "for free" by
  #   hooking into :outcomes= or similar?
  # TODO:rs replace with function to deep(?) clone outcome groups
  def replace_outcomes(new_outcomes)
    # build a hash of outcome keys => outcome mappings
    existing_outcomes = outcomes.inject({}) do |h,o|
      h[o.key] = o
      h
    end

    new_outcomes.each do |outcome|
      existing = existing_outcomes[outcome.key]
      # look for an existing outcome with this key
      existing && outcomes.delete(existing)
      # and add the outcome to our outcomes
      outcomes << outcome
    end
  end

  # TODO:eo see if these errors can be added to the outcomes
  # or outcome_mappings rather than base, for nice field highlighting?
  def ensure_outcome_key_uniqueness
    key_counts = outcomes.map(&:key).inject({}) do |h,k|
      h[k] ||= 0
      h[k] += 1
      h
    end

    key_counts.each do |key, count|
      errors.add(:base, "#{count} outcomes have key '#{key}'") if count > 1
    end
  end
end
