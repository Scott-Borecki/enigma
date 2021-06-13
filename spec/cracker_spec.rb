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
      ciphertext = 'vjqtbeaweqihssi'
      date       = '291018'
      offset     = [6, 3, 2, 4]
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

    it 'can return a hash with index position by letter' do
      expected = { "a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5,
                   "g" => 6, "h" => 7, "i" => 8, "j" => 9, "k" => 10, "l" => 11,
                   "m" => 12, "n" => 13, "o" => 14, "p" => 15, "q" => 16,
                   "r" => 17, "s" => 18, "t" => 19, "u" => 20, "v" => 21,
                   "w" => 22, "x" => 23, "y" => 24, "z" => 25, " " => 26 }
      expect(@cracker.alphabet_hash).to eq(expected)
    end

    it 'can return the last four letters of the ciphertext' do
      actual   = @cracker.ciphertext_end
      expected = ['h', 's', 's', 'i']
      expect(actual).to eq(expected)
    end

    it 'can return the known last four letters of decrypted message' do
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

    it 'can return the shift values' do
      actual   = @cracker.shift_values
      expected = [14, 5, 5, 8]
      expect(actual).to eq(expected)
    end

    it 'can generate the shift lookup hash' do
      actual   = @cracker.shift_lookup
      expected = { 0=>14, 1=>5, 2=>5, 3=>8 }
      expect(actual).to eq(expected)
    end

    it 'can generate a shift (decryption) cipher' do
      actual   = @cracker.unshift('s', 0)
      expected = 'e'
      expect(actual).to eq(expected)

      actual   = @cracker.unshift('s', 1)
      expected = 'n'
      expect(actual).to eq(expected)

      actual   = @cracker.unshift('i', 2)
      expected = 'd'
      expect(actual).to eq(expected)

      actual   = @cracker.unshift('h', 3)
      expected = ' '
      expect(actual).to eq(expected)
    end

    it 'can return an shifted letter' do
      actual   = @cracker.unshift_new_letter('$', 3)
      expected = '$'
      expect(actual).to eq(expected)

      allow(@cracker).to receive(:unshift).and_return(true)
      actual = @cracker.unshift_new_letter('d', 3)
      expect(actual).to be true
    end

    it 'can return the difference of the shift and offset' do
      allow(@cracker).to receive(:shift_values).and_return([14, 5, 5, 8])
      allow(@cracker).to receive(:offset).and_return([6, 3, 2, 4])
      actual   = @cracker.offset_key_sum
      expected = [8, 2, 3, 4]
      expect(actual).to eq(expected)
    end

    it 'can return the possibile combinations of the offset key difference' do
      allow(@cracker).to receive(:offset_key_sum).and_return([8, 2, 3, 4])
      actual   = @cracker.offset_key_sum_combos
      expected = [[8, 35, 62, 89], [2, 29, 56, 83], [3, 30, 57, 84],
                  [4, 31, 58, 85]]
      expect(actual).to eq(expected)
    end

    it 'can return the modified difference of the shift and offset' do
      modified = [[8, 35, 62, 89], [2, 29, 56, 83], [3, 30, 57, 84],
                  [4, 31, 58, 85]]
      allow(@cracker).to receive(:offset_key_sum_combos).and_return(modified)
      actual   = @cracker.offset_key_sum_modified
      expected = [8, 83, 30, 4]
      expect(actual).to eq(expected)
    end

    it 'can return the cracked key' do
      allow(@cracker).to receive(:offset_key_sum).and_return([13, 37, 74, 45])
      expect(@cracker.cracked_key).to eq('13745')

      allow(@cracker).to receive(:offset_key_sum).and_return([3, 30, 4,45])
      expect(@cracker.cracked_key).to eq('03045')

      allow(@cracker).to receive(:offset_key_sum).and_return([13, 37, 70, 5])
      expect(@cracker.cracked_key).to eq('13705')
    end
  end
end
