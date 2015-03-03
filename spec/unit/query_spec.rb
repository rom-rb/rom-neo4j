require 'spec_helper'
require 'rom/memory/dataset'

describe ROM::Neo4j::Relation do

  describe '#where' do
    it 'where equals' do
      expect(relation.to_a).to eql([matrix, reloaded])
    end

    it 'where not equals' do
      expect(relation.to_a).to eql([matrix, reloaded])
    end

    it 'where gte' do
      expect(relation.to_a).to eql([matrix, reloaded])
    end
  end

  describe '#limit' do

  end

  describe '#merge' do

  end

  describe '#order' do

  end

  describe '#order' do

  end

end
