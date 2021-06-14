require_relative 'alphabetable'
require_relative 'offset'
require_relative 'positionable'

class Cracker
  include Alphabetable
  include Positionable

  attr_reader :ciphertext,
              :date,
              :offset

  def initialize(ciphertext, date)
    @ciphertext = ciphertext.chomp
    @date       = date
    @offset     = Offset.generate(@date)
  end

  def ciphertext_end
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
      letter_position(ciphertext_end).zip(letter_position(known_end)
        .map(&:-@)).map(&:sum).map do |value|
          value.negative? ? value + 27 : value
        end.rotate(4 - ciphertext.length % 4)
  end

  def offset_key_sum
    @offset_key_sum ||= shift_values.zip(offset.map(&:-@)).map(&:sum)
  end

  def offset_key_sum_combos
    @offset_key_sum_combos ||= offset_key_sum.map do |number|
      if number > 18
        [number, number + 27, number + 27 * 2]
      else
        [number, number + 27, number + 27 * 2, number + 27 * 3]
      end
    end
  end

  def offset_key_sum_modified
    array = []
    offset_key_sum_combos.each_with_index do |nums, i|
      if i == 0
        array << nums.find do |num0|
          offset_key_sum_combos[i + 1].any? do |num1|
            if num0 % 10 == num1 / 10
              offset_key_sum_combos[i + 2].any? do |num2|
                if num1 % 10 == num2 / 10
                  offset_key_sum_combos[i + 3].any? do |num3|
                    num2 % 10 == num3 / 10
                  end
                end
              end
            end
          end
        end
      else
        array << nums.find do |num|
          array[i - 1] % 10 == num / 10
        end
      end
    end
    array
  end

  def cracked_key
    "#{offset_key_sum_modified[0].to_s.rjust(2, "0")}#{offset_key_sum_modified[1] % 10}#{offset_key_sum_modified[3].to_s.rjust(2, "0")}"
  end

  def shift_lookup
    @shift_lookup ||= positions.zip(shift_values).to_h
  end

  def unshift(letter, index)
    alphabet.zip(alphabet.rotate(shift_lookup[index % 4] * -1)).to_h[letter]
  end

  def unshift_new_letter(letter, index)
    alphabet.include?(letter) ? unshift(letter, index) : letter
  end
end
