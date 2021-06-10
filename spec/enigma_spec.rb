require './lib/enigma'
require 'date'
require 'simplecov'
SimpleCov.start

RSpec.describe Enigma do
  before :each do
    @enigma = Enigma.new
    @today  = Time.now.strftime("%d%m%y")
  end

  describe 'Object Creation' do
    it 'exists' do
      expect(@enigma).to be_an_instance_of(Enigma)
    end
  end

  describe 'Object Methods' do
    xit 'can encrypt a message with a key and date' do
      actual   = @enigma.encrypt("hello world", "02715", "040895")
      expected = {
        encryption: "keder ohulw",
        key:        "02715",
        date:       "040895"
      }
      expect(actual).to eq(expected)
    end

    xit 'can encrypt a message with a key (and today\'s date)' do
      actual   = @enigma.encrypt("hello world", "02715")
      expected = {
        encryption: "keder ohulw",
        key:        "02715",
        date:       @today
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

    xit 'can crack a message with a date' do
      actual   = @enigma.encrypt("hello world end", "08304", "291018")
      expected = {
        encryption: "vjqtbeaweqihssi",
        key:        "08304",
        date:       "291018"
      }
      expect(actual).to eq(expected)

      actual   = @enigma.crack("keder ohulw", "02715", "040895")
      expected = {
        decryption: "hello world",
        date:       "040895",
        key:        "02715"
      }
      expect(actual).to eq(expected)
    end

    xit 'can crack a message with today\'s date' do
      actual   = @enigma.encrypt("hello world end", "08304", @today)
      expected = {
        encryption: "vjqtbeaweqihssi",
        key:        "08304",
        date:       "291018"
      }
      expect(actual).to eq(expected)

      actual   = @enigma.crack("vjqtbeaweqihssi")
      expected = {
        decryption: "hello world end",
        date:       @today,
        key:        "08304"
      }
      expect(actual).to eq(expected)
    end
  end
end
