require './lib/enigma'
require 'simplecov'
SimpleCov.start

RSpec.describe Enigma do
  before :each do
    @enigma = Enigma.new
  end

  describe 'Object Creation' do
    it 'exists' do
      expect(@enigma).to be_an_instance_of(Enigma)
    end
  end
end
