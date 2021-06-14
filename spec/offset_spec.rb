require 'date'
require_relative 'spec_helper'
require_relative '../lib/offset'

RSpec.describe Offset do
  describe 'Class Methods' do
    it 'can generate the offsets' do
      actual   = Offset.generate('040895')
      expected = [1, 0, 2, 5]
      expect(actual).to eq(expected)
    end
  end

  describe 'Object Creation' do
    it 'exists' do
      offset = Offset.new
      expect(offset).to be_an_instance_of(Offset)
    end
  end
end
