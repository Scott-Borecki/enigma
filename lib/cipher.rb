require_relative 'alphabetable'
require_relative 'key'
require_relative 'offset'
require_relative 'positionable'
require_relative 'shiftable'

class Cipher
  include Alphabetable
  include Positionable
  include Shiftable

  attr_reader :keys,
              :date,
              :offset

  def initialize(date, key)
    @keys   = Key.generate(key)
    @date   = date
    @offset = Offset.generate(@date)
  end

  def shift_values
    @keys.zip(@offset).map(&:sum)
  end
end
