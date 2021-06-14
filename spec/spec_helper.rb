require_relative '../lib/alphabetable'
require_relative '../lib/dateable'
require_relative '../lib/positionable'
require_relative '../lib/shiftable'

RSpec.configure do |config|
  config.include Dateable, Alphabetable, Positionable, Shiftable
end
