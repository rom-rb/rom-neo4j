require 'neo4j-core'

require 'rom'

require 'rom/neo4j/dataset'
require 'rom/neo4j/relation'
require 'rom/neo4j/repository'

ROM.register_adapter(:neo4j, ROM::Neo4j)
