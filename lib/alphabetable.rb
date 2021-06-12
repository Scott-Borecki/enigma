# This module shares the behavior to return the alphabet (plus space) array
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
end
