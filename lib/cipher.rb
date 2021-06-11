class Cipher
  include Alphabetable

  attr_reader :key,
              :date,
              :offset

  def initialize(key, date)
    @key      = Key.generate(key)
    @date     = date
    @offset   = Offset.generate(@date)
  end

  def positions
    [0, 1, 2, 3]
  end

  def shift_lookup
    @shift_lookup ||= positions.zip(@key.zip(@offset).map(&:sum)).to_h
  end

  def shift(letter, index)
    alphabet.zip(alphabet.rotate(shift_lookup[index % 4])).to_h[letter]
  end

  def unshift(letter, index)
    alphabet.zip(alphabet.rotate(shift_lookup[index % 4] * -1)).to_h[letter]
  end
end
