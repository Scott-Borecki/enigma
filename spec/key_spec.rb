require 'date'
require_relative 'spec_helper'
require_relative '../lib/key'

RSpec.describe Key do
  describe 'Class Methods' do
    it 'can generate the key with a given key' do
      actual   = Key.generate('02715')
      expected = [2, 27, 71, 15]
      expect(actual).to eq(expected)
    end
  end

  describe 'Object Creation' do
    it 'exists' do
      key = Key.new
      expect(key).to be_an_instance_of(Key)
    end
  end
end
