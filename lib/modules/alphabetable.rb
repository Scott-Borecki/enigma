# This module shares the behaviors related to the alphabet (plus space) array
module Alphabetable
  def alphabet
    @alphabet ||= ('a'..'z').to_a << ' '
  end

  def alphabet_hash
    @alphabet_hash ||=
      alphabet.each_with_index.reduce({}) do |hash, (letter, index)|
        hash.update(letter => index)
      end
  end

  def letter_position(letters)
    letters.map { |letter| alphabet_hash[letter] }
  end

  def num_letters
    alphabet.length
  end
end
