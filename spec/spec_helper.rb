require 'simplecov'
require_relative '../lib/modules/alphabetable'
require_relative '../lib/modules/dateable'
require_relative '../lib/modules/shiftable'

SimpleCov.start

RSpec.configure do |config|
  config.include Dateable, Alphabetable, Shiftable
end
