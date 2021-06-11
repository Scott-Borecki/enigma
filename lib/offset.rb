class Offset
  def self.generate(date)
    (date.to_i**2).digits.reverse[-4..-1]
  end
end
