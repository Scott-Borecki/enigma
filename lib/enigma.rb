class Enigma
  include Alphabetable
  include Dateable

  def encrypt(message, key, date = today)
    # FIXME: key needs to return string value in return hash.
    cipher = Cipher.new(key, date)
    encrypted_message = ''
    message.chars.each_with_index.reduce('') do |encrypted, (letter, index)|
      encrypted_message << cipher.shift_new_letter(letter, index)
    end
    { encryption: encrypted_message, key: key, date: date }
  end

  def decrypt(ciphertext, key, date)
    # FIXME: key needs to return string value in return hash.
    cipher = Cipher.new(key, date)
    decrypted_message = ''
    ciphertext.chars.each_with_index do |letter, index|
      decrypted_message << cipher.unshift_new_letter(letter, index)
    end
    { decryption: decrypted_message, key: key, date: date }
  end

  # def crack(ciphertext, date = today)
  #   # TODO
  # end
end
