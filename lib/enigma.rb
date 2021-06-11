class Enigma
  include Alphabetable
  include Dateable

  def encrypt(message, key, date = today)
    # HACK: This code needs to be refactored.  Abstract symbol and modulo.
    cipher = Cipher.new(key, date)
    encrypted_message = ''
    message.chars.each_with_index do |letter, index|
      encrypted_message << letter unless alphabet.include?(letter)
      # encrypted_message << cipher.shift(letter, index)
      encrypted_message << cipher.shift(:A)[letter] if (index % 4).zero?
      encrypted_message << cipher.shift(:B)[letter] if index % 4 == 1
      encrypted_message << cipher.shift(:C)[letter] if index % 4 == 2
      encrypted_message << cipher.shift(:D)[letter] if index % 4 == 3
    end
    { encryption: encrypted_message,
      key:        key,
      date:       date }
  end

  def decrypt(ciphertext, key, date)
    # HACK: This code needs to be refactored.  Abstract symbol and modulo.
    cipher = Cipher.new(key, date)
    decrypted_message = ''
    ciphertext.chars.each_with_index do |letter, index|
      decrypted_message << letter unless alphabet.include?(letter)
      # decrypted_message << cipher.unshift(letter, index)
      decrypted_message << cipher.unshift(:A)[letter] if (index % 4).zero?
      decrypted_message << cipher.unshift(:B)[letter] if index % 4 == 1
      decrypted_message << cipher.unshift(:C)[letter] if index % 4 == 2
      decrypted_message << cipher.unshift(:D)[letter] if index % 4 == 3
    end
    { decryption: decrypted_message,
      key:        key,
      date:       date }
  end

  def crack(ciphertext, date = today)
    # TODO
  end
end
