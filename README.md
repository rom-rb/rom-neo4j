[gem]: https://rubygems.org/gems/rom-neo4j
[travis]: https://travis-ci.org/rom-rb/rom-neo4j
[gemnasium]: https://gemnasium.com/rom-rb/rom-neo4j
[codeclimate]: https://codeclimate.com/github/rom-rb/rom-neo4j
[inchpages]: http://inch-ci.org/github/rom-rb/rom-neo4j

# ROM::Neo4j

[![Gem Version](https://badge.fury.io/rb/rom-neo4j.svg)][gem]
[![Build Status](https://travis-ci.org/rom-rb/rom-neo4j.svg?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/rom-rb/rom-neo4j.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/rom-rb/rom-neo4j/badges/gpa.svg)][codeclimate]
[![Test Coverage](https://codeclimate.com/github/rom-rb/rom-neo4j/badges/coverage.svg)][codeclimate]
[![Inline docs](http://inch-ci.org/github/rom-rb/rom-neo4j.svg?branch=master)][inchpages]

Map objects returned from Neo4j graph traversals using the [Ruby Object Mapper](https://github.com/rom-rb/rom) toolkit.

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

movie = rom.relation(:movies).titled('The Matrix').one
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

director = rom.relation(:directors).by_movie('RescueDawn').one
director.name # => "Werner Herzog"
```

## Roadmap

- 0.1.0 Relation/Dataset for mapping cypher traversals
- 0.2.0 Basic Commands integration
- 0.4.0 Documentation and usage examples
- 0.5.0 Prefix mapping and node/rel helpers
