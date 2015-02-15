module ROM
  module Neo4j
    # A dataset represents a collection returned from a query traversal over a
    # sub-graph.
    #
    # Datasets are Enumerable objects and can be manipulated using the standard
    # methods, `each`, `map`, `inject`, and so forth.
    class Dataset

      # @see http://www.rubydoc.info/gems/neo4j-core/Neo4j/Core/Query
      # @param query [Neo4j::Core::Query] Query object returned from a Neo4j connection
      def initialize(query)
        @query = query
      end

      def to_cypher
        @query.to_cypher
      end

      def each(&iter)
        @query.each(&iter)
      end

      def where(*conditions)
        self.class.new(@query.where(*conditions))
      end

      def start(*conditions)
        self.class.new(@query.start(*conditions))
      end

      def match(*conditions)
        self.class.new(@query.match(*conditions))
      end

      def return(*conditions)
        self.class.new(@query.return(*conditions))
      end

      def limit(*conditions)
        self.class.new(@query.limit(*conditions))
      end

      def merge(*conditions)
        self.class.new(@query.merge(*conditions))
      end

      def order(*conditions)
        self.class.new(@query.order(*conditions))
      end

      def optional_match(*conditions)
        self.class.new(@query.optional_match(*conditions))
      end

      def params(*conditions)
        self.class.new(@query.params(*conditions))
      end

    end

  end
end
