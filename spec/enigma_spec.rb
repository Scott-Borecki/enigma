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

  describe 'Object Methods' do
    xit 'can encrypt a message' do
      actual   = @enigma.encrypt("hello world", "02715", "040895")
      expected = {
        encryption: "keder ohulw",
        key:        "02715",
        date:       "040895"
      }
      expect(actual).to eq(expected)
    end

    xit 'can encrypt and decrypt a message' do
      actual   = @enigma.encrypt("hello world", "02715", "040895")
      expected = {
        encryption: "keder ohulw",
        key:        "02715",
        date:       "040895"
      }
      expect(actual).to eq(expected)

      actual   = @enigma.decrypt("keder ohulw", "02715", "040895")
      expected = {
        decryption: "hello world",
        key:        "02715",
        date:       "040895"
      }
      expect(actual).to eq(expected)
    end
  end
end
