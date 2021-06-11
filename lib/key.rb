class Key
  def self.generate(key = Array.new(5) { rand(0..9) })
    # HACK: This code needs to be refactored.
    key = key.chars.map(&:to_i) if key.is_a?(String)
    [key[0] * 10 + key[1],
     key[1] * 10 + key[2],
     key[2] * 10 + key[3],
     key[3] * 10 + key[4]]
    # key_array = @keys
    # new_key = []
    # @keys.each_with_index.map do |value, i|
    #   i < 4 ? j = i + 1 : j = 0
    #   new_key << key_array[i] * 10 + key_array[j] if i < 5
    #   new_key
    # end
    # new_key.pop
    # new_key
  end

  def initialize
  end
end
