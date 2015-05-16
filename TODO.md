# TODO

## Features

- Add command wrapper
- Surface write capabilities from Neo4j::Core
- Support embedded mode (JRuby only)

## API

- Class method/DSL/convention for relation shared SELECT/MATCH
- Wrapper with prefix/select (?)

## Mappers

- Find out why prefix mapping isn't working

## Dataset

- Add batch finders
- Add find by index, find by id, and find by label
- Unit test of cypher query building
- Documentation of instance methods

## Specs

- ~~Add webmock or VCR and dump local requests to movies dataset~~
- Fix jruby build on Travis
- ~~Get Travis builds working with local install of Neo4j server and remove VCR~~
- Complete query building unit test
- Ensure relation spec is up to date with 0.7 ROM conventions

## Housekeeping

- Add LICENSE
- Tidy up README
