require 'spec_helper'
require 'rom/lint/spec'

describe 'Neo4j adapter' do
  let(:dsn) { 'http://localhost:7474' }
  let(:setup) { ROM.setup(:neo4j, dsn) }

  context 'with movies relation and mapper' do
    let(:rom) do
      setup.relation(:movies) do
        matches m: :Movie
        #returns m: [:title, :released, :tagline]
        returns ['m.title AS title', 'm.released AS released', 'm.tagline as tagline']

        def by_title(title)
          where('m.title' => title)
        end

        def by_year(year)
          where('m.released' => year)
        end
      end

      setup.mappers do
        define(:movies) do
          relation :movies
          model name: 'Movie'
          # prefix :m
          # prefix_separator '.'
          attribute :title
          attribute :released
          attribute :tagline
        end
      end

      setup.finalize
    end

    let(:movies) do
      rom.relation(:movies)
    end

    it 'maps movies #by_title' do
      movies.by_title('The Matrix').as(:movies).first.tap do |movie|
        expect(movie).to be_a(Movie)
        expect(movie.title).to eql('The Matrix')
        expect(movie.released).to eql(1999)
        expect(movie.tagline).to eql('Welcome to the Real World')
      end
    end

    it 'maps movies #by_year' do
      expect(movies.by_year(1999).to_a.count).to eq(4)
    end
  end

  context 'with directors relation and mapper' do
    let(:rom) do
      setup.relation(:directors) do
        matches '(director:Person)-[:DIRECTED]->(movie:Movie)'
        returns 'DISTINCT director.name AS name'

        def by_movie(title)
          where('movie.title' => title)
        end
      end

      setup.mappers do
        define(:directors) do
          relation :directors
          model name: 'Director'
          attribute :name
        end
      end

      setup.finalize
    end

    let(:directors) do
      rom.relation(:directors)
    end

    it 'maps directors #by_movie_title' do
      directors.by_movie('RescueDawn').as(:directors).first.tap do |director|
        expect(director).to be_a(Director)
        expect(director.name).to eql('Werner Herzog')
      end
    end
  end
end