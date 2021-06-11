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

  def symbols
    %i[A B C D]
  end

  def shift_lookup
    @shift_lookup ||= symbols.zip(@key.zip(@offset).map(&:sum)).to_h
  end

  def shift(symbol)
    # HACK: Refactor to take two arguments, shift(letter, index) #=> shifted letter
    alphabet.zip(alphabet.rotate(shift_lookup[symbol])).to_h
  end

  def unshift(symbol)
    # HACK: efactor to take two arguments, shift(letter, index) #=> unshifted letter
    alphabet.zip(alphabet.rotate(shift_lookup[symbol] * -1)).to_h
  end
end
