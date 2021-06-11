class Cipher
  include Dateable

  attr_reader :alphabet,
              :message,
              :key,
              :date,
              :offset

  def initialize(message, key, date)
    @alphabet = ('a'..'z').to_a << ' '
    @message  = message
    @key      = Key.generate(key)
    @date     = date || today
    @offset   = Offset.generate(@date)
  end

  def symbols
    %i[A B C D]
  end

  def generate_shift
    symbols.zip(@key.zip(@offset).map(&:sum)).to_h
  end
end
