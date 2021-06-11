require 'date'
require 'simplecov'
require_relative 'spec_helper'
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

    it 'has readable attributes' do
      expected = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
                  'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
                  'y', 'z', ' ']
      expect(@enigma.alphabet).to be_a(Array)
      expect(@enigma.alphabet).to eq(expected)
      expect(@enigma.alphabet.length).to eq(27)
    end
  end

  describe 'Object Methods' do
    describe 'Encryption and Decryption' do
      it 'can encrypt a message with a key and date' do
        actual   = @enigma.encrypt('hello world', '02715', '040895')
        expected = {
          encryption: 'keder ohulw',
          key:        '02715',
          date:       '040895'
        }
        expect(actual).to eq(expected)
      end

      it "can encrypt a message with a key (and today's date)" do
        allow(@enigma).to receive(:today).and_return('040895')
        actual   = @enigma.encrypt('hello world', '02715')
        expected = {
          encryption: 'keder ohulw',
          key:        '02715',
          date:       '040895'
        }
        expect(actual).to eq(expected)
      end

      it 'can encrypt and decrypt a message' do
        actual   = @enigma.encrypt('hello world', '02715', '040895')
        expected = {
          encryption: 'keder ohulw',
          key:        '02715',
          date:       '040895'
        }
        expect(actual).to eq(expected)

        actual   = @enigma.decrypt('keder ohulw', '02715', '040895')
        expected = {
          decryption: 'hello world',
          key:        '02715',
          date:       '040895'
        }
        expect(actual).to eq(expected)
      end

      xit 'can crack a message with a date' do
        actual   = @enigma.encrypt('hello world end', '08304', '291018')
        expected = {
          encryption: 'vjqtbeaweqihssi',
          key:        '08304',
          date:       '291018'
        }
        expect(actual).to eq(expected)

        actual   = @enigma.crack('keder ohulw', '02715', '040895')
        expected = {
          decryption: 'hello world',
          date:       '040895',
          key:        '02715'
        }
        expect(actual).to eq(expected)
      end

      xit "can crack a message with today's date" do
        actual   = @enigma.encrypt('hello world end', '08304', today)
        expected = {
          encryption: 'vjqtbeaweqihssi',
          key:        '08304',
          date:       '291018'
        }
        expect(actual).to eq(expected)

        actual   = @enigma.crack('vjqtbeaweqihssi')
        expected = {
          decryption: 'hello world end',
          date:       today,
          key:        '08304'
        }
        expect(actual).to eq(expected)
      end
    end

    describe 'Generate Methods' do
      it 'can generate keys' do
        actual = @enigma.keys
        expect(actual).to be_a(Array)
        expect(actual.length).to eq(4)
        expect(actual.find_all { |key| key.is_a? Integer }.length).to eq(4)
      end

      it 'can generate offsets' do
        actual   = @enigma.offsets('040895')
        expected = [1, 0, 2, 5]
        expect(actual).to eq(expected)
      end

      it 'can generate symbols' do
        actual   = @enigma.symbols
        expected = %i[A B C D]
        expect(actual).to eq(expected)
      end

      xit 'can generate shift' do
        allow(@enigma).to receive(:offsets)
          .and_return(A: 1, B: 0, C: 2, D: 5)
        allow(@enigma).to receive(:keys)
          .and_return(A: 2, B: 27, C: 71, D: 15)
        actual   = @enigma.generate_shift
        expected = { A: 3, B: 27, C: 73, D: 20 }
        expect(actual).to eq(expected)
      end

      it 'can merge two hashes and sum the keys' do
        keys     = [2, 27, 71, 15]
        offsets  = [1, 0, 2, 5]

        actual   = @enigma.merge_it(keys, offsets)
        expected = { A: 3, B: 27, C: 73, D: 20 }
        expect(actual).to eq(expected)
      end

      it 'can create sum values from two arrays' do
        keys     = [2, 27, 71, 15]
        offsets  = [1, 0, 2, 5]

        actual   = @enigma.sum_values(keys, offsets)
        expected = [3, 27, 73, 20]
        expect(actual).to eq(expected)
      end
    end
  end
end
