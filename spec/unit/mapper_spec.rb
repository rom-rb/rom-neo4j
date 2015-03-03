require 'spec_helper'

describe 'mapper' do
  
  describe '#each' do
    xit 'yields all mapped objects' do
      result = []

      mapper.call(relation).each do |tuple|
        result << tuple
      end

      expect(result).to eql([jane, joe])
    end
  end

end
