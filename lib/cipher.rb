class Cipher
  include Alphabetable

  attr_reader :keys,
              :date,
              :offset

  def initialize(date, key)
    @keys     = Key.generate(key)
    @date     = date
    @offset   = Offset.generate(@date)
  end

  def positions
    [0, 1, 2, 3]
  end

  def shift_lookup
    @shift_lookup ||= positions.zip(@keys.zip(@offset).map(&:sum)).to_h
  end

  def shift(letter, index)
    alphabet.zip(alphabet.rotate(shift_lookup[index % 4])).to_h[letter]
  end

  def shift_new_letter(letter, index)
    alphabet.include?(letter) ? shift(letter, index) : letter
  end

  def unshift(letter, index)
    alphabet.zip(alphabet.rotate(shift_lookup[index % 4] * -1)).to_h[letter]
  end

  def unshift_new_letter(letter, index)
    alphabet.include?(letter) ? unshift(letter, index) : letter
  end
end
