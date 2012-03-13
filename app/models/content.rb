# Holds some piece of course content(lecture topics, assignments)
# and the group it belongs to
#
class Content < ActiveRecord::Base
  belongs_to :content_group
  has_one :offering, :through => :content_group

  has_many :mappings, :as => :mappable, dependent: :destroy
  has_many :outcomes, :through => :mappings

  acts_as_list :scope => :content_group_id

  accepts_nested_attributes_for :mappings

  validates :title, :presence => true
  validates_associated :mappings

  default_scope order(:position)

  def to_s
    title
  end

  def clones_with_mappings(new_content_group)
    cnt = Content.create! position: position, title: title,
      content_group: new_content_group

    mappings.each do |mapping|
      mapping.clone_for_mappable(cnt)
    end
  end

  def clones_without_mappings(new_content_group)
    cnt = Content.create! position: position, title: title,
      content_group: new_content_group
  end

end
