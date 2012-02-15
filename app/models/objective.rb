# Course objectives are textual descriptions and act as an ordered list
#
class Objective < ActiveRecord::Base
  belongs_to :offering

  has_many :mappings, :as => :mappable
  has_many :mapped_outcomes,
    source: :outcome,
    through: :mappings,
    class_name: 'Outcome'

  accepts_nested_attributes_for :mappings

  acts_as_list :scope => :offering_id

  validates :description, :presence => true

  def to_s
    description
  end

end
