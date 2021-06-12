require_relative '../lib/alphabetable'
require_relative '../lib/dateable'
require_relative '../lib/positionable'

RSpec.configure do |config|
  config.include Dateable, Alphabetable, Positionable
end
