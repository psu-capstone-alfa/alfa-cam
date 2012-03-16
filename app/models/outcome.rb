# Program outcomes are the expected student results of graduating the program
#
class Outcome < ActiveRecord::Base
  has_many :outcome_mappings, inverse_of: :outcome
  belongs_to :outcome_group

  acts_as_list scope: :outcome_group

  default_scope order: :key

  validates_presence_of :key, :description

  before_destroy :check_for_associated

  def to_s
    "#{key}:#{description.truncate(20)}"
  end

  private
    def check_for_associated
      unless outcome_mappings.empty?
        errors[:base] << "Cannot delete offering when it is mapped"
      end
    end
end
