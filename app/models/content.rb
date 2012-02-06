# Holds some piece of course content(lecture topics, assignments)
# and the group it belongs to
#
class Content < ActiveRecord::Base
  belongs_to :content_group
  has_one :offering, :through => :content_group

  has_many :mappings, :as => :mappable
  has_many :outcomes, :through => :mappings

  acts_as_list :scope => :content_group_id

  accepts_nested_attributes_for :mappings

  validates :title, :presence => true
  validates_associated :mappings
end
