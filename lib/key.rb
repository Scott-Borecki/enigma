class Key
  # TODO: Allow Key object to store key so it can return it later.
  #       Maybe have self.generate make a 5 digit string and then transform?
  def self.generate(key = Array.new(5) { rand(0..9) })
    # TODO: This code needs to be refactored.
    key = key.chars.map(&:to_i) if key.is_a?(String)
    [key[0] * 10 + key[1],
     key[1] * 10 + key[2],
     key[2] * 10 + key[3],
     key[3] * 10 + key[4]]
  end
end
