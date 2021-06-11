require 'date'
require 'simplecov'
require_relative 'spec_helper'
require_relative '../lib/cipher'
require_relative '../lib/key'
require_relative '../lib/offset'

SimpleCov.start

RSpec.describe Cipher do
  before :each do
    @cipher = Cipher.new('02715', '040895')
  end

  describe 'Object Creation' do
    it 'exists' do
      expect(@cipher).to be_an_instance_of(Cipher)
    end

    it 'has readable attributes' do
      key    = [2, 27, 71, 15]
      date   = '040895'
      offset = [1, 0, 2, 5]
      expect(@cipher.key).to eq(key)
      expect(@cipher.date).to eq(date)
      expect(@cipher.offset).to eq(offset)
    end
  end

  describe 'Object Methods' do
    it 'can return the alphabet (plus space)' do
      alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
                  'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
                  'y', 'z', ' ']
      expect(@cipher.alphabet).to eq(alphabet)
    end

    it 'can generate positions' do
      actual   = @cipher.positions
      expected = [0, 1, 2, 3]
      expect(actual).to eq(expected)
    end

    it 'can generate the shift lookup hash' do
      actual   = @cipher.shift_lookup
      expected = { 0 => 3, 1 => 27, 2 => 73, 3 => 20 }
      expect(actual).to eq(expected)
    end

    it 'can generate a shift (encryption) pcipher' do
      actual   = @cipher.shift('a', 0)
      expected = 'd'
      expect(actual).to eq(expected)
    end

    it 'can generate a unshift (decryption) cipher' do
      actual   = @cipher.unshift('a', 0)
      expected = 'y'
      expect(actual).to eq(expected)
    end
  end
end
