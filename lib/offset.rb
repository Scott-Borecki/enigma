require_relative 'modules/positionable'

class Offset
  extend Positionable

  def self.generate(date)
    (date.to_i**2).digits.reverse.last(num_positions)
  end
end
