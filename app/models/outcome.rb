# Program outcomes are the expected student results of graduating the program
#
class Outcome < ActiveRecord::Base
  has_many :outcome_mappings, inverse_of: :outcome
  has_many :outcome_groups, through: :outcome_mappings

  validates :title, :key, :description, :presence => true
#  validates :key, format: {
#    with: /[A-Z]/,
#    message: 'only singular capital letters allowed'
#  }

  def to_s
    "#{key}:#{title}"
  end
end
