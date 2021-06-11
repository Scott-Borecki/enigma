class Key
  def self.generate(key = Array.new(5) { rand(0..9) })
    # TODO: This code needs to be refactored.
    key = key.chars.map(&:to_i) if key.is_a?(String)
    [key[0] * 10 + key[1],
     key[1] * 10 + key[2],
     key[2] * 10 + key[3],
     key[3] * 10 + key[4]]
  end
end
