# Program outcomes are the expected student results of graduating the program
#
class Outcome < ActiveRecord::Base
  has_many :outcome_mappings, inverse_of: :outcome
  belongs_to :outcome_group

  acts_as_list scope: :outcome_group

  validates :title, :key, :description, :presence => true

  def to_s
    "#{key}:#{title}"
  end
end
