# ROM Neo4j

Map objects returned from Neo4j graph traversals using the ROM toolkit.

## Status

Incomplete experimental sketch.

The adapter spec passes with the generic movies dataset distributed with Neo4j, but that's about all at this point.

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

A work in progress.
