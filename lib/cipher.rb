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

  def generate_shift
    symbols.zip(@key.zip(@offset).map(&:sum)).to_h
  end

  def shift(symbol)
    alphabet.zip(alphabet.rotate(generate_shift[symbol])).to_h
  end

  def unshift(symbol)
    alphabet.zip(alphabet.rotate(generate_shift[symbol] * -1)).to_h
  end
end
