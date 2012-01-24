class Objective < ActiveRecord::Base
  validates :description, :presence => true
  belongs_to :offering
end
