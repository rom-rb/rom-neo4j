require 'spec_helper'
require 'rom/memory/dataset'

describe ROM::Neo4j::Relation do
  subject(:relation) { Class.new(ROM::Neo4j::Relation).new(dataset) }

  let(:dataset) { ROM::Memory::Dataset.new([matrix, reloaded]) }

  let(:matrix) { { title: 'The Matrix', released: 1999 } }
  let(:reloaded) { { title: 'The Matrix Reloaded', released: 2003 } }

  describe '#each' do
    it 'yields all objects' do
      result = []

      relation.each do |user|
        result << user
      end

      expect(result).to eql([matrix, reloaded])
    end

    it 'returns an enumerator if block is not provided' do
      expect(relation.each).to be_instance_of(Enumerator)
    end
  end

  describe '#to_a' do
    it 'materializes relation to an array' do
      expect(relation.to_a).to eql([matrix, reloaded])
    end
  end
  
end
