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

  default_scope order(:position)

  def to_s
    description
  end

  def clones_without_mapping(new_offering)
    obj = Objective.create! offering: new_offering, description: description
  end

  def clones_with_mapping(new_offering)
    obj = Objective.create! offering: new_offering, description: description
    mappings.each do |mapping|
      mapping.clone_for_mappable(obj)
    end
  end

end
