# ROM::Neo4j

Map objects returned from Neo4j graph traversals using the [Ruby Object Mapper](https://github.com/rom-rb/rom) toolkit.

## Status

[![Build Status](https://travis-ci.org/rom-rb/rom-neo4j.svg?branch=master)](https://travis-ci.org/rom-rb/rom-neo4j)

## Install

Install with Rubygems:

```
gem install rom-neo4j
```

Or add the dependency to your `Gemfile`:

```
gem 'rom-neo4j'
```

Right now, the fastest way to get started is to run the tests.

You’ll need to have Neo4j installed on your system. If it’s not already running, start the database server with:

```
neo4j start
```

To load the sample movies graph, go to `http://localhost:7474/browser/` and click through the instructions or type `:play movie graph` in the console to start.

Once the movies graph is loaded, the integration specs should run:

```
rspec specs/integration
```

## Examples

### Cypher DSL

```ruby
setup.relation(:movies) do
  matches m: :Movie
  returns m: [:title, :released, :tagline]

  def titled(title)
    where('m.title' => title)
  end
end

movie = rom.read(:movies).titled('The Matrix').first
movie.title   # => "The Matrix"
movie.updated # => 1999
```

### Raw Cypher Queries

```ruby
setup.relation(:directors) do
  matches '(director:Person)-[:DIRECTED]->(movie:Movie)'
  returns 'DISTINCT director.name as name'

  def by_movie(title)
    where('movie.title' => title)
  end
end

director = rom.read(:directors).by_movie('RescueDawn').first
director.name # => "Werner Herzog"
```

## Roadmap

- 0.1.0 Relation/Dataset for mapping cypher traversals
- 0.2.0 Basic Commands integration
- 0.4.0 Documentation and usage examples
- 0.5.0 Prefix mapping and node/rel helpers
