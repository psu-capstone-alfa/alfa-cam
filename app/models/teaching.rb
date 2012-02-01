
# Captures the many-to-many relationship of instructors(users)
# teaching a class(offering)
#
class Teaching < ActiveRecord::Base
  belongs_to :instructor, class_name: 'User', foreign_key: 'user_id'
  belongs_to :offering
end
