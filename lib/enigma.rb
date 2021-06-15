require_relative 'modules/dateable'
require_relative 'cipher'
require_relative 'cracker'

class Enigma
  include Dateable

  def encrypt(message, key, date = today)
    cipher    = Cipher.new(date, key)
    encrypted = ''
    message.chars.each_with_index do |letter, index|
      encrypted << cipher.shift_new_letter(letter, index)
    end
    { encryption: encrypted, key: key, date: date }
  end

  def decrypt(ciphertext, key, date)
    cipher    = Cipher.new(date, key)
    decrypted = ''
    ciphertext.chars.each_with_index do |letter, index|
      decrypted << cipher.shift_new_letter(letter, index, -1)
    end
    { decryption: decrypted, key: key, date: date }
  end

  def crack(ciphertext, date = today)
    cracker = Cracker.new(ciphertext, date)
    cracked = ''
    ciphertext.chars.each_with_index do |letter, index|
      cracked << cracker.shift_new_letter(letter, index, -1)
    end
    { decryption: cracked, key: cracker.key, date: date }
  end
end
