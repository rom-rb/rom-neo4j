require 'spec_helper'

require 'rom/lint/spec'

describe 'Neo4j adapter' do

  # TODO: clean up the global state and allow multiple contexts to run cleanly

  subject(:rom) { setup.finalize }

  let(:dsn) { 'http://localhost:7474' }
  let(:setup) { ROM.setup(:neo4j, dsn) }

  before do

    setup.relation(:movies) do
      matches m: :Movie
      returns m: [:title, :released, :tagline]

      def titled(title)
        where('m.title' => title)
      end

    end

    setup.relation(:directors) do
      matches '(director:Person)-[:DIRECTED]->(movie:Movie)'
      returns 'DISTINCT director.name as name'

      def by_movie(title)
        where('movie.title' => title)
      end

    end

    setup.mappers do

      define(:movies) do
        model name: 'Movie'

        prefix :m
        prefix_separator '.'

        attribute :title
        attribute :released
        attribute :tagline
      end

      define(:directors) do
        model name: 'Director'

        attribute :name
      end

    end
  end

  describe 'env#read' do
    it 'returns mapped object from #titled relation' do
      movie = rom.read(:movies).titled('The Matrix').first

      expect(movie.title).to eql('The Matrix')
      expect(movie.released).to eql(1999)
      expect(movie.tagline).to eql('Welcome to the Real World')

      director = rom.read(:directors).by_movie('RescueDawn').first

      expect(director.name).to eql('Werner Herzog')
    end
  end
end