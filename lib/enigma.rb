class Enigma
  include Alphabetable
  include Dateable

  def encrypt(message, key, date = today)
    # TODO: This code needs to be refactored.  Abstract symbol and modulo.
    cipher = Cipher.new(key, date)
    encrypted_message = ''
    message.chars.each_with_index do |letter, index|
      encrypted_message <<
        (alphabet.include?(letter) ? cipher.shift(letter, index) : letter)
    end
    { encryption: encrypted_message, key: key, date: date }
  end

  def decrypt(ciphertext, key, date)
    # TODO: This code needs to be refactored.  Abstract symbol and modulo.
    cipher = Cipher.new(key, date)
    decrypted_message = ''
    ciphertext.chars.each_with_index do |letter, index|
      decrypted_message <<
        (alphabet.include?(letter) ? cipher.unshift(letter, index) : letter)
    end
    { decryption: decrypted_message, key: key, date: date }
  end

  def crack(ciphertext, date = today)
    # TODO
  end
end
