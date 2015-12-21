# Extensions to the Neo4j::Core library making it easier to integrate with ROM.

# TODO (2015-11-22) Neo4j core is being updated to 6.0.0 soon-- we are working
# to expose an API so that this functionality can be achieved without the below
# monkey patches, so this whole section should be regarded as temporary.

module Neo4j
  module Core
    UnsupportedDriver = Class.new(StandardError)

    # This patches Query so that it returns Hashes rather than Neo4j::Node
    # objects. We don't want Neo4j::Nodes in our Relations

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

  # Has the same effect as the above patch to query, except this makes
  # CypherSession#query return hashes instead of nodes. The practical effect is
  # that you now get Hashes whether you pass a raw Cypher string or use the
  # Cypher DSL with CypherSession#query.

  module Server

    class CypherSession < Neo4j::Session

      alias_method :original_query, :query

      def query(*args)
        if args.first.is_a?(String)
          query, params = args[0,2]
          response = _query(query, params)
          response.raise_error if response.error?
          response.to_struct_enumeration(query)
        else
          original_query(*args)
        end
      end

    end

  end

end
