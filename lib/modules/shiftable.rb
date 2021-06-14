# This module shares the letter shifting behavior
module Shiftable
  def shift_lookup
    @shift_lookup ||= positions.zip(shift_values).to_h
  end

  def shift(letter, index)
    alphabet.zip(alphabet.rotate(shift_lookup[index % 4])).to_h[letter]
  end

  def shift_new_letter(letter, index)
    alphabet.include?(letter) ? shift(letter, index) : letter
  end

  def unshift(letter, index)
    alphabet.zip(alphabet.rotate(shift_lookup[index % 4] * -1)).to_h[letter]
  end

  def unshift_new_letter(letter, index)
    alphabet.include?(letter) ? unshift(letter, index) : letter
  end
end
