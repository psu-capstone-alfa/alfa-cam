# Collects similar course contents for displaying grouped
#
class ContentGroup < ActiveRecord::Base
  belongs_to :content_group_name
  delegate :name, to: :content_group_name

  belongs_to :offering
  has_many :outcomes, :through => :offering

  has_many :content do
    def build_with_mappings(outcomes)
      new_content = self.build
      outcomes.each do |outcome|
        new_content.mappings.build(:outcome => outcome)
      end
      return new_content
    end
  end

  validates_associated :content

  # don't accept completely empty content rows
  REJECT = ->(c) do
    c['title'].blank? and (c['mappings_attributes'].all? do |i,m|
                             m['value'].blank?
                           end)
  end
  accepts_nested_attributes_for :content,
    reject_if: REJECT,
    allow_destroy: true

  def to_s
    name
  end

  def clones_with_mappings(new_offering)
    group = ContentGroup.create!({
      offering_id: new_offering,
      content_group_name_id: content_group_name_id
    })
    content.each do |content|
      content.clones_with_mappings(group)
    end
  end

  def clones_without_mappings(new_offering)
    group = ContentGroup.create! offering_id: new_offering, name: name
    content.each do |content|
      content.clones_without_mappings(group)
    end
  end

end
