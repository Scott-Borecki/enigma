require './lib/dateable'

class Enigma
  include Dateable

  attr_reader :alphabet

  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def encrypt(message, key, date = today)
    @keys = key.split(//).map(&:to_i)
    keys
    offsets(date)
    generate_shift
    encrypted_message = []
    message.split(//).each_with_index do |letter, index|
      encrypted_message << letter unless @alphabet.include?(letter)
      encrypted_message << shift_it(:A)[letter] if index % 4 == 0
      encrypted_message << shift_it(:B)[letter] if index % 4 == 1
      encrypted_message << shift_it(:C)[letter] if index % 4 == 2
      encrypted_message << shift_it(:D)[letter] if index % 4 == 3
    end
    {
      encryption: encrypted_message.join,
      key:        key,
      date:       date
    }
  end

  def decrypt(ciphertext, key, date)
    @keys = key.split(//).map(&:to_i)
    keys
    offsets(date)
    generate_shift
    decrypted_message = []
    ciphertext.split(//).each_with_index do |letter, index|
      decrypted_message << letter unless @alphabet.include?(letter)
      decrypted_message << unshift_it(:A)[letter] if index % 4 == 0
      decrypted_message << unshift_it(:B)[letter] if index % 4 == 1
      decrypted_message << unshift_it(:C)[letter] if index % 4 == 2
      decrypted_message << unshift_it(:D)[letter] if index % 4 == 3
    end
    {
      decryption: decrypted_message.join,
      key:        key,
      date:       date
    }
  end

  def crack(ciphertext, date = today)
  end

  def keys
    @keys ||= Array.new(5) { rand(0...9) }
    return if @keys.length == 4
    @keys = [@keys[0] * 10 + @keys[1], @keys[1] * 10 + @keys[2], @keys[2] * 10 + @keys[3], @keys[3] * 10 + @keys[4]]
    # key_array = @keys
    # new_key = []
    # @keys.each_with_index.map do |value, i|
    #   i < 4 ? j = i + 1 : j = 0
    #   new_key << key_array[i] * 10 + key_array[j] if i < 5
    #   new_key
    # end
    # new_key.pop
    # new_key
  end

  def offsets(date)
    @offsets ||= (date.to_i ** 2).digits.reverse[-4..-1]
  end

  def symbols
    %i( A B C D )
  end

  def generate_shift
    @generate_shift ||= merge_it(@keys, @offsets)
  end

  def merge_it(key, offset)
    symbols.zip(sum_values(key, offset)).to_h
    # h1.merge(h2) { |k, v1, v2| v1 + v2 }
  end

  def sum_values(array1, array2)
    # require "pry"; binding.pry
    array1.zip(array2).map(&:sum)
  end

  def shift_it(symbol)
    @alphabet.zip(@alphabet.rotate(@generate_shift[symbol])).to_h
  end

  def unshift_it(symbol)
    @alphabet.zip(@alphabet.rotate(@generate_shift[symbol] * -1)).to_h
  end
end
