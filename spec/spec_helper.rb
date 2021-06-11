require_relative '../lib/alphabetable'
require_relative '../lib/dateable'

RSpec.configure do |config|
  config.include Dateable, Alphabetable
end
