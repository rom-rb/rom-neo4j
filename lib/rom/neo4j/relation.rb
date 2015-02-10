module ROM

  module Neo4j

    # Relation supporting Cypher graph traversals. Configure the sub-graph
    # for the relation by specifying a `match` pattern, and collect a dataset
    # for mapping by specifying nodes, edges and properties in the `returns`.
    class Relation < ROM::Relation

      forward :where

      # @api private
      def self.inherited(klass)
        klass.instance_variable_set('@start_anchor', false)
        klass.instance_variable_set('@match_anchor', false)
        klass.instance_variable_set('@return_structure', false)
        super
      end

      # Specify a `START` node for the for the relation's graph traversal. This
      # is only required for legacy indexes. In most cases Cypher can infer the
      # starting points to anchor a graph traversal from the pattern specified
      # in a `MATCH` clause.
      #
      # @see http://neo4j.com/docs/stable/query-start.html
      #
      def self.start(*args)
        @start_node = args
      end

      # Specify a `MATCH` clause for the relation's graph traversal. If you’re
      # coming from the SQL world, you can think of this as similar to a
      # `SELECT FROM`, except that it matches on a topological structure rather
      # than a schema.
      #
      # @example Reproduce SQL style projections by passing node labels directly.
      #
      #   setup.relation(:movies) do
      #     matches m: :movie
      #   end
      #
      # @example Specify topological matches using Cypher's ASCII-art syntax.
      #
      #   setup.relation(:actors) do
      #     matches '(actor:Person)-[:ACTED_IN]->(movie)'
      #   end
      #
      # @see http://neo4j.com/docs/stable/query-match.html
      #
      def self.matches(*args)
        @match_anchor = args
      end

      # Specify a `RETURN` clause for the relation. This will define the
      # structure of objects in the returned dataset.
      #
      # Any combination of nodes, edges and properties can be selected, as well
      # as custom aliases and distinct objects.
      #
      # @see http://neo4j.com/docs/stable/query-return.html
      #
      def self.returns(*args)
        @return_structure = args
      end

      # @api private
      def self.finalize(relations, relation)
        relation.dataset.graph_start_node(@start_node)
        relation.dataset.graph_match_anchor(@match_anchor)
        relation.dataset.graph_return_structure(@return_structure)
      end

    end

  end
end
