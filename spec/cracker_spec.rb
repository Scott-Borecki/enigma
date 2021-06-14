require 'date'
require 'simplecov'
require_relative 'spec_helper'
require_relative '../lib/cracker'
require_relative '../lib/key'
require_relative '../lib/key_cracker'
require_relative '../lib/offset'

SimpleCov.start

RSpec.describe Cracker do
  before :each do
    @cracker = Cracker.new('vjqtbeaweqihssi', '291018')
    @cracker1 = Cracker.new('wbtrcxdufilftkl', '130621')
    @cracker2 = Cracker.new('ewvwlrfzocnkben', '140621')
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

      ciphertext = 'wbtrcxdufilftkl'
      date       = '130621'
      offset     = [5, 6, 4, 1]
      expect(@cracker1.ciphertext).to eq(ciphertext)
      expect(@cracker1.date).to eq(date)
      expect(@cracker1.offset).to eq(offset)

      ciphertext = 'ewvwlrfzocnkben'
      date       = '140621'
      offset     = [5, 6, 4, 1]
      expect(@cracker2.ciphertext).to eq(ciphertext)
      expect(@cracker2.date).to eq(date)
      expect(@cracker2.offset).to eq(offset)
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
      expected = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5,
                   'g' => 6, 'h' => 7, 'i' => 8, 'j' => 9, 'k' => 10, 'l' => 11,
                   'm' => 12, 'n' => 13, 'o' => 14, 'p' => 15, 'q' => 16,
                   'r' => 17, 's' => 18, 't' => 19, 'u' => 20, 'v' => 21,
                   'w' => 22, 'x' => 23, 'y' => 24, 'z' => 25, ' ' => 26 }
      expect(@cracker.alphabet_hash).to eq(expected)
    end

    it 'can return the last four letters of the ciphertext' do
      actual   = @cracker.ciphertext_end
      expected = %w[h s s i]
      expect(actual).to eq(expected)

      actual   = @cracker1.ciphertext_end
      expected = %w[f t k l]
      expect(actual).to eq(expected)
    end

    it 'can return the known last four letters of decrypted message' do
      expect(@cracker.known_end).to eq([' ', 'e', 'n', 'd'])
    end

    it 'can return the letter positions' do
      actual   = @cracker.letter_position([' ', 'e', 'n', 'd'])
      expected = [26, 4, 13, 3]
      expect(actual).to eq(expected)

      actual   = @cracker.letter_position(%w[h s s i])
      expected = [7, 18, 18, 8]
      expect(actual).to eq(expected)
    end

    it 'can return the shift values' do
      actual   = @cracker.shift_values
      expected = [14, 5, 5, 8]
      expect(actual).to eq(expected)

      actual   = @cracker1.shift_values
      expected = [15, 24, 8, 6]
      expect(actual).to eq(expected)
    end

    it 'can return positive shift values from negative shift values' do
      array    = [15, -12, 4, -7]
      actual   = @cracker.positive_shifts(array)
      expected = [15, 15, 4, 20]
      expect(actual).to eq(expected)
    end

    it 'can generate the shift lookup hash' do
      actual   = @cracker.shift_lookup
      expected = { 0 => 14, 1 => 5, 2 => 5, 3 => 8 }
      expect(actual).to eq(expected)

      actual   = @cracker1.shift_lookup
      expected = { 0 => 15, 1 => 24, 2 => 8, 3 => 6 }
      expect(actual).to eq(expected)
    end

    it 'can generate an unshift (decryption) cipher' do
      actual   = @cracker.shift('s', 0, -1)
      expected = 'e'
      expect(actual).to eq(expected)

      actual   = @cracker.shift('s', 1, -1)
      expected = 'n'
      expect(actual).to eq(expected)

      actual   = @cracker.shift('i', 2, -1)
      expected = 'd'
      expect(actual).to eq(expected)

      actual   = @cracker.shift('h', 3, -1)
      expected = ' '
      expect(actual).to eq(expected)

      actual   = @cracker1.shift('f', 3, -1)
      expected = ' '
      expect(actual).to eq(expected)
    end

    it 'can return an unshifted letter' do
      actual   = @cracker.shift_new_letter('$', 3, -1)
      expected = '$'
      expect(actual).to eq(expected)

      allow(@cracker).to receive(:shift).and_return(true)
      actual = @cracker.shift_new_letter('d', 3, -1)
      expect(actual).to be true
    end
  end
end
