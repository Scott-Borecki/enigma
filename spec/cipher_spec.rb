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

    it 'can generate symbols' do
      actual   = @cipher.symbols
      expected = %i[A B C D]
      expect(actual).to eq(expected)
    end

    it 'can generate the shift lookup hash' do
      actual   = @cipher.shift_lookup
      expected = { A: 3, B: 27, C: 73, D: 20 }
      expect(actual).to eq(expected)
    end

    it 'can generate a shift (encryption) pcipher' do
      actual   = @cipher.shift(:A)
      expected = { 'a' => 'd', 'b' => 'e', 'c' => 'f', 'd' => 'g', 'e' => 'h',
                   'f' => 'i', 'g' => 'j', 'h' => 'k', 'i' => 'l', 'j' => 'm',
                   'k' => 'n', 'l' => 'o', 'm' => 'p', 'n' => 'q', 'o' => 'r',
                   'p' => 's', 'q' => 't', 'r' => 'u', 's' => 'v', 't' => 'w',
                   'u' => 'x', 'v' => 'y', 'w' => 'z', 'x' => ' ', 'y' => 'a',
                   'z' => 'b', ' ' => 'c' }
      expect(actual).to eq(expected)
    end

    it 'can generate a unshift (decryption) cipher' do
      actual   = @cipher.unshift(:A)
      expected = { 'a' => 'y', 'b' => 'z', 'c' => ' ', 'd' => 'a', 'e' => 'b',
                   'f' => 'c', 'g' => 'd', 'h' => 'e', 'i' => 'f', 'j' => 'g',
                   'k' => 'h', 'l' => 'i', 'm' => 'j', 'n' => 'k', 'o' => 'l',
                   'p' => 'm', 'q' => 'n', 'r' => 'o', 's' => 'p', 't' => 'q',
                   'u' => 'r', 'v' => 's', 'w' => 't', 'x' => 'u', 'y' => 'v',
                   'z' => 'w', ' ' => 'x' }
      expect(actual).to eq(expected)
    end
  end
end
