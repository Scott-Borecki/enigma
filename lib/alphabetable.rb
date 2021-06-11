# This module shares the behavior to return the alphabet (plus space) array
module Alphabetable
  def alphabet
    @alphabet ||= ('a'..'z').to_a << ' '
  end
end
