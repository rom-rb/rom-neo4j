require 'neo4j-core'

require 'rom'

require 'rom/neo4j/dataset'
require 'rom/neo4j/relation'
require 'rom/neo4j/gateway'
require 'rom/neo4j/commands'
require 'rom/neo4j/support/core_ext'
require 'rom/neo4j/transproc_functions'

ROM.register_adapter(:neo4j, ROM::Neo4j)
