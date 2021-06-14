require_relative 'alphabetable'
require_relative 'key_cracker'
require_relative 'offset'
require_relative 'positionable'
require_relative 'shiftable'

class Cracker
  include Alphabetable
  include Positionable
  include Shiftable

  attr_reader :ciphertext,
              :date,
              :offset,
              :key

  def initialize(ciphertext, date)
    @ciphertext = ciphertext.chomp
    @date       = date
    @offset     = Offset.generate(@date)
    @key        = KeyCracker.new(shift_values, offset).key
  end

  def ciphertext_end
    ciphertext[-4..-1].chars
  end

  def known_end
    ' end'.chars
  end

  def shift_values
    # HACK: Assignment Branch Condition size for shift_values is too high.
    @shift_values ||=
      positive_shifts(letter_position(ciphertext_end)
        .zip(letter_position(known_end).map(&:-@)).map(&:sum))
          .rotate(4 - ciphertext.length % 4)
  end

  def positive_shifts(array)
    array.map { |value| value.negative? ? value + alphabet.length : value }
  end
end
