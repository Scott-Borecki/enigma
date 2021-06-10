require './lib/dateable'

class Enigma
  include Dateable

  def initialize
  end

  def encrypt(message, key, date = today)
  end

  def decrypt(ciphertext, key, date)
  end

  def crack(ciphertext, date = today)
  end
end
