# Academic terms are a period of time in which courses are taught
#
class AcademicTerm < ActiveRecord::Base
  validates :title, :presence => true
  has_many :offerings

  before_destroy :check_for_offerings
  def check_for_offerings()
    unless offering_ids.empty?
      self.errors[:base] << "Sorry, you cannot delete a term with offerings."
      false
    end
  end
end
