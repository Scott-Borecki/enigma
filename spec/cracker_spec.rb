require 'date'
require 'simplecov'
require_relative 'spec_helper'
require_relative '../lib/cracker'
require_relative '../lib/key'
require_relative '../lib/offset'

SimpleCov.start

RSpec.describe Cracker do
  before :each do
    @cracker = Cracker.new('vjqtbeaweqihssi', '291018')
  end

  describe 'Object Creation' do
    it 'exists' do
      expect(@cracker).to be_an_instance_of(Cracker)
    end

    it 'has readable attributes' do
      keys       = ''
      ciphertext = 'vjqtbeaweqihssi'
      date       = '291018'
      offset     = [6, 3, 2, 4]
      expect(@cracker.keys).to eq(keys)
      expect(@cracker.ciphertext).to eq(ciphertext)
      expect(@cracker.date).to eq(date)
      expect(@cracker.offset).to eq(offset)
    end
  end

  describe 'Object Methods' do
    it 'can return the alphabet (plus space)' do
      alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
                  'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
                  'y', 'z', ' ']
      expect(@cracker.alphabet).to eq(alphabet)
    end

    it 'can return a hash with index position  by letter' do
      expected = { "a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5,
                   "g" => 6, "h" => 7, "i" => 8, "j" => 9, "k" => 10, "l" => 11,
                   "m" => 12, "n" => 13, "o" => 14, "p" => 15, "q" => 16,
                   "r" => 17, "s" => 18, "t" => 19, "u" => 20, "v" => 21,
                   "w" => 22, "x" => 23, "y" => 24, "z" => 25, " " => 26 }
      expect(@cracker.alphabet_hash).to eq(expected)
    end

    it 'can return the last four letters of the ciphertext' do
      actual   = @cracker.last_four_ciphertext
      expected = ['h', 's', 's', 'i']
      expect(actual).to eq(expected)
    end

    it 'can return the known end of message' do
      expect(@cracker.known_end).to eq([' ', 'e', 'n', 'd'])
    end

    it 'can return the letter positions' do
      actual   = @cracker.letter_position([' ', 'e', 'n', 'd'])
      expected = [26, 4, 13, 3]
      expect(actual).to eq(expected)

      actual   = @cracker.letter_position(['h', 's', 's', 'i'])
      expected = [7, 18, 18, 8]
      expect(actual).to eq(expected)
    end
  end
end
