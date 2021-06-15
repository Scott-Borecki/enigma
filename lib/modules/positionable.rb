module Positionable
  def num_positions
    4
  end

  def positions
    @positions ||= [*0..(num_positions - 1)]
  end
end
