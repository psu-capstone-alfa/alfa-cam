# Course objectives are textual descriptions and act as an ordered list
#
class Objective < ActiveRecord::Base
  validates :description, :presence => true
  belongs_to :offering

  def to_s
    description
  end
end
