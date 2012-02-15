# Represents the numerical mapping against program outcomes
# Used for course content and objectives
#
class Mapping < ActiveRecord::Base
  belongs_to :mappable, :polymorphic => true
  belongs_to :outcome

  def to_s
    "#{mappable} maps to #{outcome} with #{value}"
  end
end
