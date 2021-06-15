module Shiftable
  def shift_lookup
    @shift_lookup ||= positions.zip(shift_values).to_h
  end

  def shift(letter, index, sign)
    alphabet.zip(alphabet.rotate(shift_lookup[index % num_positions] * sign))
      .to_h[letter]
  end

  def shift_new_letter(letter, index, sign = 1)
    alphabet.include?(letter) ? shift(letter, index, sign) : letter
  end
end
