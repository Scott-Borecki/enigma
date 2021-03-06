require_relative 'modules/alphabetable'

class KeyCracker
  include Alphabetable

  attr_reader :shift_values,
              :offset

  def initialize(shift_values, offset)
    @shift_values = shift_values
    @offset       = offset
  end

  def shift_diff
    @shift_diff ||= shift_values.zip(offset.map(&:-@)).map(&:sum)
  end

  def shift_diff_combos
    @shift_diff_combos ||=
      shift_diff.map do |num|
        counter = 0
        array   = []
        while num + num_letters * counter <= 99
          array << num + num_letters * counter
          counter += 1
        end
        array
      end
  end

  def shift_diff_keys
    array = []
    shift_diff_combos.each_with_index do |nums, i|
      i.zero? ? array << shift_0(nums, i) : array << shift_123(nums, array, i)
    end
    @keys = array
  end

  def shift_0(nums, i)
    nums.find do |num0|
      shift_diff_combos[i + 1].any? do |num1|
        if num0 % 10 == num1 / 10
          shift_diff_combos[i + 2].any? do |num2|
            if num1 % 10 == num2 / 10
              shift_diff_combos[i + 3].any? do |num3|
                num2 % 10 == num3 / 10
              end
            end
          end
        end
      end
    end
  end

  def shift_123(nums, array, i)
    nums.find { |num| array[i - 1] % 10 == num / 10 }
  end

  def keys
    @keys ||= shift_diff_keys
  end

  def key
    "#{keys[0].to_s.rjust(2, '0')}"\
    "#{keys[1] % 10}"\
    "#{keys[3].to_s.rjust(2, '0')}"
  end
end
