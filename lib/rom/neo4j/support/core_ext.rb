# Extensions to the Neo4j::Core library making it easier to integrate with ROM.
module Neo4j
  module Core
    UnsupportedDriver = Class.new(StandardError)

    # DSL for generating Cypher queries and enumerating their results.
    #
    # @see http://www.rubydoc.info/gems/neo4j-core/Neo4j/Core/Query
    class Query
      # Exports the underlying session handle.
      # @return [Neo4j::Session]
      attr_reader :session

      def each
        return enum_for(:each) unless block_given?

        response = self.response
        columns = response.columns.map { |c| c.to_sym }

        if response.is_a?(Neo4j::Server::CypherResponse)
          response.data.map do |row|
            yield Hash[columns.zip(row)]
          end
        else
          raise Neo4j::Core::UnsupportedDriver, 'Neo4j::Embedded is not supported (yet)'
        end
      end
    end
  end
end
