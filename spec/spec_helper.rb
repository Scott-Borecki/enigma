require_relative '../lib/modules/alphabetable'
require_relative '../lib/modules/dateable'
require_relative '../lib/modules/positionable'
require_relative '../lib/modules/shiftable'

RSpec.configure do |config|
  config.include Dateable, Alphabetable, Positionable, Shiftable
end
