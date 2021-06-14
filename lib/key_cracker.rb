class KeyCracker
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
    # HACK: Figure out a better way to to this. Maybe until loop?
    @shift_diff_combos ||= shift_diff.map do |number|
      if number > 18
        [number, number + 27, number + 27 * 2]
      else
        [number, number + 27, number + 27 * 2, number + 27 * 3]
      end
    end
  end

  def shift_diff_keys
    # HACK: Figure out way to use the return of the conditional for variable
    #       assignment and comparison.
    # HACK: Assignment Branch Condition size for shift_diff_keys is too
    #       high.
    array = []
    shift_diff_combos.each_with_index do |nums, i|
      if i.zero?
        array << nums.find do |num0|
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
      else
        array << nums.find do |num|
          array[i - 1] % 10 == num / 10
        end
      end
    end
    @keys = array
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
