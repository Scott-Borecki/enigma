class Cracker
  include Alphabetable
  include Positionable

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

  def shift_values
    @shift_values ||=
      letter_position(known_end).zip(letter_position(last_four_ciphertext)
        .map(&:-@)).map(&:sum).map do |value|
          value.negative? ? value + 27 : value
        end
  end

  def offset_key_sum
    shift_values.zip(offset.map(&:-@)).map(&:sum)
  end

  # def keys
  #   @key = "#{offset_key_sum[0]}#{offset_key_sum[0]}#{offset_key_sum[0]}#{offset_key_sum[0]}#{offset_key_sum[0]}"
  # end

  def positions_rotated
    positions.rotate(ciphertext.length % 4)
  end

  def shift_lookup
    @shift_lookup ||= positions_rotated.zip(shift_values).to_h
  end

  def shift(letter, index)
    alphabet.zip(alphabet.rotate(shift_lookup[index % 4])).to_h[letter]
  end

  def shift_new_letter(letter, index)
    alphabet.include?(letter) ? shift(letter, index) : letter
  end
end
