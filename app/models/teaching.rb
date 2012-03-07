
# Captures the many-to-many relationship of instructors(users)
# teaching a class(offering)
#
class Teaching < ActiveRecord::Base
  belongs_to :instructor, class_name: 'User', foreign_key: 'user_id'
  belongs_to :offering

  validates :user_id, presence: true
  # because Teachings can be created using nested attributes on the
  # bulk Offering form, this validation causes a cycle which prevents
  # validation ever succeeding when creating a new Offering/Teaching
  # combo. therefore, only run when offering is present
  validates :offering_id, presence: true, unless: 'offering.blank?'

  def to_s
    "#{instructor}: #{offering}"
  end
end
