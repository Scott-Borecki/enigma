require_relative 'modules/alphabetable'
require_relative 'modules/shiftable'
require_relative 'modules/positionable'
require_relative 'key_cracker'
require_relative 'offset'

class Cracker
  include Alphabetable
  include Shiftable
  include Positionable

  attr_reader :ciphertext,
              :date,
              :offset,
              :key

  def initialize(ciphertext, date)
    @ciphertext = ciphertext
    @date       = date
    @offset     = Offset.generate(@date)
    @key        = KeyCracker.new(shift_values, offset).key
  end

  def ciphertext_end
    ciphertext.chars.last(4)
  end

  def known_end
    ' end'.chars
  end

  def shift_values
    @shift_values ||=
      positive_shifts(letter_position(ciphertext_end)
        .zip(letter_position(known_end).map(&:-@)).map(&:sum))
        .rotate(num_positions - ciphertext.length % num_positions)
  end

  def positive_shifts(array)
    array.map { |value| value.negative? ? value + num_letters : value }
  end
end
