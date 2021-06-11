require 'date'
require 'simplecov'
require_relative 'spec_helper'
require_relative '../lib/key'

SimpleCov.start

RSpec.describe Key do
  describe 'Class Methods' do
    it 'can generate the keys' do
      actual = Key.generate
      expect(actual).to be_a(Array)
      expect(actual.length).to eq(4)
      expect(actual.find_all { |key| key.is_a?(Integer) }.length).to eq(4)
    end
  end

  describe 'Object Creation' do
    it 'exists' do
      key = Key.new
      expect(key).to be_an_instance_of(Key)
    end
  end
end
