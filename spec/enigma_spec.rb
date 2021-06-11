require 'date'
require 'simplecov'
require_relative 'spec_helper'
require_relative '../lib/cipher'
require_relative '../lib/enigma'

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
    it 'can return the alphabet (plus space)' do
      alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
                  'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
                  'y', 'z', ' ']
      expect(@enigma.alphabet).to eq(alphabet)
    end

    it "can return today's date as a DDMMYY string" do
      expect(@enigma.today).to be_a(String)
      expect(@enigma.today.length).to eq(6)
    end

    it 'can encrypt a message with a key and date' do
      actual   = @enigma.encrypt('hello world', '02715', '040895')
      expected = { encryption: 'keder ohulw', key: '02715', date: '040895' }
      expect(actual).to eq(expected)
    end

    it "can encrypt a message with a key (and today's date)" do
      allow(@enigma).to receive(:today).and_return('040895')
      actual   = @enigma.encrypt('hello world', '02715')
      expected = { encryption: 'keder ohulw', key: '02715', date: '040895' }
      expect(actual).to eq(expected)
    end

    it 'can encrypt and decrypt a message' do
      actual   = @enigma.encrypt('hello world', '02715', '040895')
      expected = { encryption: 'keder ohulw', key: '02715', date: '040895' }
      expect(actual).to eq(expected)

      actual   = @enigma.decrypt('keder ohulw', '02715', '040895')
      expected = { decryption: 'hello world', key: '02715', date: '040895' }
      expect(actual).to eq(expected)
    end

    xit 'can crack a message with a date' do
      actual   = @enigma.encrypt('hello world end', '08304', '291018')
      expected = { encryption: 'vjqtbeaweqihssi', key: '08304', date: '291018' }
      expect(actual).to eq(expected)

      actual   = @enigma.crack('keder ohulw', '02715', '040895')
      expected = { decryption: 'hello world', date: '040895', key: '02715' }
      expect(actual).to eq(expected)
    end

    xit "can crack a message with today's date" do
      actual   = @enigma.encrypt('hello world end', '08304', today)
      expected = { encryption: 'vjqtbeaweqihssi', key: '08304', date: '291018' }
      expect(actual).to eq(expected)

      actual   = @enigma.crack('vjqtbeaweqihssi')
      expected = { decryption: 'hello world end', date: today, key: '08304' }
      expect(actual).to eq(expected)
    end
  end
end
