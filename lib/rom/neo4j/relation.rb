module ROM

  # TODO: this is all README driven development, and not yet implemented in the spec.

  module Neo4j

    # Relation supporting Cypher graph traversals. Configure the pipeline
    # by specifying a `start` node, or a `match` clause, and collect a dataset
    # for mapping by specifying a `returns` clause.
    class Relation < ROM::Relation

      def self.inherited(klass)
        klass.instance_variable_set('@start_clause', nil)
        klass.instance_variable_set('@match_clause', nil)
        klass.instance_variable_set('@returns_clause', nil)
        super
      end

      # Specify a starting node for the graph traversal. If not specified,
      # the query starts from the root node and will potentially traverse
      # the entire graph.
      #
      def self.start(*args)
        @start_clause = args
      end

      # Specify a matching clause for the graph traversal. If you’re coming
      # from the SQL world, you can think of this as similar to a `SELECT FROM`,
      # except that it matches on a topological structure rather than a schema.
      #
      # @example Reproduce SQL style projections by passing node labels directly.
      #
      #   setup.relation(:movies) do
      #     match m: :movie
      #   end
      #
      # @example Specify topological matches using Cypher's ASCII-art syntax.
      #
      #   setup.relation(:actors) do
      #     match '(actor:Person)-[:ACTED_IN]->(movie)'
      #   end
      #
      def self.match(*args)
        @match_clause = args
      end

      # Specify a return clause for the relation. This will define the structure of
      # objects that can be mapped from the returned dataset.
      #
      # @todo Is `self.return` valid Ruby syntax? This seems to blow up Sublime Text's syntax
      #       highlighter, but I haven't yet checked whether or not it will parse correctly.
      #
      def self.returns(*args)
        @returns_clause = args
      end

    end

  end
end
