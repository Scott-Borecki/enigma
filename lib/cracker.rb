class Cracker
  include Alphabetable

  attr_reader :keys,
              :ciphertext,
              :date,
              :offset

  def initialize(ciphertext, date)
    @keys       = ''
    @ciphertext = ciphertext
    @date       = date
    @offset     = Offset.generate(@date)
  end

  def last_four_ciphertext
    ciphertext[-4..-1].chars
  end

  def known_end
    ' end'.chars
  end

  def letter_position(letters)
    letters.map { |letter| alphabet_hash[letter] }
  end
end
