class Key
  def self.generate(key)
    # TODO: This code needs to be refactored.
    key = key.chars.map(&:to_i)
    [key[0] * 10 + key[1],
     key[1] * 10 + key[2],
     key[2] * 10 + key[3],
     key[3] * 10 + key[4]]
  end
end
