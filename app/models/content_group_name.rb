# Available ContentGroupNames will be present when
# creating a new offering
#
class ContentGroupName < ActiveRecord::Base
  has_many :content_groups

  scope :active, where(active: true)

  before_destroy :check_for_association

  def self.to_content_groups
    active.all.map {|cgn| cgn.content_groups.build }
  end

  def to_s
    name
  end

  private
    def check_for_association
      unless content_groups.empty?
        errors[:base] << "You cannot delete a Content Group when it is in use"
        false
      end
    end
end
