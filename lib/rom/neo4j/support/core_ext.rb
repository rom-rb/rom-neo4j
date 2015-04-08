# Extensions to the Neo4j::Core library making it easier to integrate with ROM.
module Neo4j
  module Core
    UnsupportedDriverError = Class.new(Error)
    # DSL for generating Cypher queries and enumerating their results
    #
    # @see http://www.rubydoc.info/gems/neo4j-core/Neo4j/Core/Query
    class Query
      def each
        response = self.response
        if response.is_a?(Neo4j::Server::CypherResponse)
          response.each_data_row do |row|
            yield row
          end
        else
          raise UnsupportedDriverError, 'Neo4j::Embedded is not supported (yet)'
        end
      end
    end
  end
end
