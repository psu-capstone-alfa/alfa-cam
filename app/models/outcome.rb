# Program outcomes are the expected student results of graduating the program
#
class Outcome < ActiveRecord::Base
  has_many :outcome_mappings, inverse_of: :outcome
  belongs_to :outcome_group

  acts_as_list scope: :outcome_group

  validates :title, :key, :description, :presence => true

  before_destroy :check_for_associated

  def to_s
    "#{key}:#{title}"
  end

  private
    def check_for_associated
      unless outcome_mappings.empty?
        errors[:base] << "Cannot delete offering when it is mapped"
      end
    end
end
