class Offering < ActiveRecord::Base
  belongs_to :course
  belongs_to :term

  validates :course_id, :term_id, :presence => true
end
