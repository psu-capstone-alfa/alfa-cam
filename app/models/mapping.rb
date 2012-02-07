# Represents the numerical mapping against program outcomes
# Used for course content and objectives
#
class Mapping < ActiveRecord::Base
  belongs_to :mappable, :polymorphic => true
  belongs_to :outcome

  # TODO:rs I'm not sure value restrictions should be hard-coded,
  #   I would prefer some sort of soft-fail
  validates :value, presence: true, inclusion: { in: 0..10 }
end
