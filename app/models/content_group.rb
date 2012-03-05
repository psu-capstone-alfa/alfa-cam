# Collects similar course contents for displaying grouped
#
class ContentGroup < ActiveRecord::Base
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

  validates :name, presence: true
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

  def name
    self['name'] || 'New Content Group'
  end

  def to_s
    name
  end

  def clones_with_mappings(new_offering)
    group = ContentGroup.create! offering_id: new_offering, name: name,
      created_at: created_at, updated_at: updated_at
    content.each do |content|
      content.clones_with_mappings(group)
    end
  end

  def clones_without_mappings(new_offering)
    group = ContentGroup.create! offering_id: new_offering, name: name,
      created_at: created_at, updated_at: updated_at
    content.each do |content|
      content.clones_without_mappings(group)
    end
  end

end
