require 'date'
require_relative 'spec_helper'
require_relative '../lib/key_cracker'

RSpec.describe KeyCracker do
  before :each do
    @key_cracker1 = KeyCracker.new([14, 5, 5, 8], [6, 3, 2, 4])
    @key_cracker2 = KeyCracker.new([24, 18, 10, 11], [5, 6, 4, 1])
  end

  describe 'Object Creation' do
    it 'exists' do
      expect(@key_cracker1).to be_an_instance_of(KeyCracker)
      expect(@key_cracker2).to be_an_instance_of(KeyCracker)
    end

    it 'has readable attributes' do
      shift_values = [14, 5, 5, 8]
      offset       = [6, 3, 2, 4]
      expect(@key_cracker1.shift_values).to eq(shift_values)
      expect(@key_cracker1.offset).to eq(offset)

      shift_values = [24, 18, 10, 11]
      offset       = [5, 6, 4, 1]
      expect(@key_cracker2.shift_values).to eq(shift_values)
      expect(@key_cracker2.offset).to eq(offset)
    end
  end

  describe 'Object Methods' do
    it 'can return the difference of the shift and offset' do
      actual   = @key_cracker1.shift_diff
      expected = [8, 2, 3, 4]
      expect(actual).to eq(expected)

      actual   = @key_cracker2.shift_diff
      expected = [19, 12, 6, 10]
      expect(actual).to eq(expected)
    end

    it 'can return the possibile combinations of the offset key difference' do
      allow(@key_cracker1).to receive(:shift_diff).and_return([8, 2, 3, 4])
      actual   = @key_cracker1.shift_diff_combos
      expected = [[8, 35, 62, 89], [2, 29, 56, 83], [3, 30, 57, 84],
                  [4, 31, 58, 85]]
      expect(actual).to eq(expected)

      allow(@key_cracker2).to receive(:shift_diff).and_return([19, 12, 6, 10])
      actual   = @key_cracker2.shift_diff_combos
      expected = [[19, 46, 73], [12, 39, 66, 93], [6, 33, 60, 87],
                  [10, 37, 64, 91]]
      expect(actual).to eq(expected)
    end

    it 'can return the modified difference of the shift and offset' do
      combos = [[8, 35, 62, 89], [2, 29, 56, 83], [3, 30, 57, 84],
                [4, 31, 58, 85]]
      allow(@key_cracker1).to receive(:shift_diff_combos).and_return(combos)
      actual   = @key_cracker1.shift_diff_keys
      expected = [8, 83, 30, 4]
      expect(actual).to eq(expected)

      combos = [[19, 46, 73], [12, 39, 66, 93], [6, 33, 60, 87],
                [10, 37, 64, 91]]
      allow(@key_cracker2).to receive(:shift_diff_combos).and_return(combos)
      actual   = @key_cracker2.shift_diff_keys
      expected = [19, 93, 33, 37]
      expect(actual).to eq(expected)
    end

    it 'can crack the first element of the key' do
      combos = [[8, 35, 62, 89], [2, 29, 56, 83], [3, 30, 57, 84],
                [4, 31, 58, 85]]
      nums   = [8, 35, 62, 89]
      i      = 0
      allow(@key_cracker1).to receive(:shift_diff_combos).and_return(combos)
      actual   = @key_cracker1.shift_0(nums, i)
      expected = 8
      expect(actual).to eq(expected)
    end

    it 'can crack the remaining elements of key' do
      nums  = [2, 29, 56, 83]
      array = [8]
      i     = 0
      actual   = @key_cracker1.shift_123(nums, array, i)
      expected = 83
      expect(actual).to eq(expected)
    end

    it 'can return the cracked key' do
      allow(@key_cracker1).to receive(:keys)
        .and_return([13, 37, 74, 45])
      expect(@key_cracker1.key).to eq('13745')

      allow(@key_cracker1).to receive(:keys)
        .and_return([3, 30, 4, 45])
      expect(@key_cracker1.key).to eq('03045')

      allow(@key_cracker1).to receive(:keys)
        .and_return([13, 37, 70, 5])
      expect(@key_cracker1.key).to eq('13705')
    end
  end
end
