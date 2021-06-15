class Key
  def self.randomize
    rand(99_999).to_s.rjust(5, '0')
  end

  def self.generate(key)
    keys = key.chars.map(&:to_i)
    keys.each_with_index.reduce([]) do |new_keys, (key, i)|
      new_keys << (keys[i] * 10 + keys[i + 1]) if i < 4
      new_keys
    end
  end
end
