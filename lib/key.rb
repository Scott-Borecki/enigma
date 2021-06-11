class Key
  def self.generate
    # HACK: This code needs to be refactored.
    keys = Array.new(5) { rand(0..9) }
    # return if @keys.length == 4
    [keys[0] * 10 + keys[1],
     keys[1] * 10 + keys[2],
     keys[2] * 10 + keys[3],
     keys[3] * 10 + keys[4]]
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
