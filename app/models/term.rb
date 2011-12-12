class Term < ActiveRecord::Base
  has_many :offerings

  before_destroy :check_for_offerings
  before_update :check_for_offerings

  def check_for_offerings()
    if self.offerings.count > 0
      self.errors[:base] << "Sorry, you cannot edit or delete a term with offerings."
      false
    end
  end

end
