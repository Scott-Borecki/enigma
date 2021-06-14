require_relative 'modules/alphabetable'
require_relative 'modules/shiftable'
require_relative 'key'
require_relative 'offset'

class Cipher
  include Alphabetable
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
