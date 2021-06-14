# This module shares the behavior to return the position array
module Positionable
  def positions
    @positions ||= [0, 1, 2, 3]
  end
end
