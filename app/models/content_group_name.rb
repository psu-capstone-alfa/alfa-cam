class ContentGroupName < ActiveRecord::Base
  has_many :content_groups

  scope :active, where(active: true)

  def self.to_content_groups
    active.all.map {|cgn| cgn.content_groups.build }
  end
end
