require 'date'
require 'simplecov'
require_relative 'spec_helper'
require_relative '../lib/cipher'
require_relative '../lib/key'
require_relative '../lib/offset'

SimpleCov.start

RSpec.describe Cipher do
  describe 'Class Methods' do
    # it 'can generate the offsets' do
    #   actual   = Offset.generate('040895')
    #   expected = [1, 0, 2, 5]
    #   expect(actual).to eq(expected)
    # end
  end

  describe 'Object Creation' do
    before :each do
      @cipher = Cipher.new('hello world', '02715', '040895')
    end

    it 'exists' do
      expect(@cipher).to be_an_instance_of(Cipher)
    end

    it 'has readable attributes' do
      alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
                  'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
                  'y', 'z', ' ']
      message  = 'hello world'
      key      = [2, 27, 71, 15]
      date     = '040895'
      offset   = [1, 0, 2, 5]
      expect(@cipher.alphabet).to be_a(Array)
      expect(@cipher.alphabet.length).to eq(27)
      expect(@cipher.alphabet).to eq(alphabet)
      expect(@cipher.message).to eq(message)
      expect(@cipher.key).to eq(key)
      expect(@cipher.date).to eq(date)
      expect(@cipher.offset).to eq(offset)
    end
  end

  describe 'Object Methods' do
    before :each do
      @cipher = Cipher.new('hello world', '02715', '040895')
    end

    it 'can generate symbols' do
      actual   = @cipher.symbols
      expected = %i[A B C D]
      expect(actual).to eq(expected)
    end

    it 'can generate the shift' do
      actual   = @cipher.generate_shift
      expected = { A: 3, B: 27, C: 73, D: 20 }
      expect(actual).to eq(expected)
    end
  end
end
