require 'spec_helper'

require 'rom/lint/spec'

describe 'Neo4j adapter' do
  subject(:rom) { setup.finalize }

  let(:dsn) { 'http://localhost:7474' }
  let(:setup) { ROM.setup(:neo4j, dsn) }

  before do

    setup.relation(:movies) do

      match m: :movies
      returns :m

      def titled(title)
        where(title: title)
      end

      def released_in(year)
        where(released: year)
      end

    end

    setup.mappers do
      define(:movies) do
        model name: 'Movie'

        prefix "m."
        symbolize_keys true

        attribute :title
        attribute :released
        attribute :tagline
      end
    end
  end

  describe 'env#read' do
    it 'returns mapped object from #titled relation' do
      matrix = rom.read(:movies).titled('The Matrix').first

      expect(matrix.title).to eql('The Matrix')
      expect(matrix.released).to eql(1999)
      expect(matrix.tagline).to eql('Welcome to the Real World')
    end

    it 'returns mapped object from #released_in relation' do
      matrix = rom.read(:movies).released_in(1999).first

      expect(matrix.title).to eql('The Matrix')
      expect(matrix.released).to eql(1999)
      expect(matrix.tagline).to eql('Welcome to the Real World')
    end
  end
end