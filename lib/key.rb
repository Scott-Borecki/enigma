class Key
  def self.generate(key)
    keys = key.chars.map(&:to_i)
    keys.each_with_index.reduce([]) do |new_keys, (key, i)|
      j = i + 1
      new_keys << (keys[i] * 10 + keys[j]) if i < 4
      new_keys
    end
  end
end
