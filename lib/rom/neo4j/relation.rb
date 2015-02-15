module ROM
  module Neo4j

    # Relation supporting Cypher graph traversals. Configure the sub-graph
    # for the relation by specifying a `match` pattern, and collect a dataset
    # for mapping by specifying nodes, edges and properties in the `returns`.
    class Relation < ROM::Relation

      # TODO: document these methods
      forward(
        :start, :match, :where, :return, :limit, :merge, :order,
        :optional_match, :params
      )

      # The row iterator. Calling this kicks off the actual query to the
      # database server.
      #
      # Before triggering the enumerator, it rebuilds the dataset with the
      # default traversal configured by the relation DSL.
      #
      def each(&iter)
        # TODO: can this configured by the repository?
        self.class.traversal.each do |query_method, conditions|
          @dataset = @dataset.send(query_method.to_sym, *conditions) if conditions
        end

        @dataset.each(&iter)
      end

      # Builds data structures to configure the relation DSL.
      # @api private
      def self.inherited(klass)
        klass.class_eval do
          class << self
            attr_reader :traversal
          end
        end
        klass.instance_variable_set('@traversal', {
          start: false, match: false, return: false
        })
        super
      end

      # Specify a `START` node for the for the relation's graph traversal. This
      # is only required for legacy indexes. In most cases Cypher can infer the
      # starting points to anchor a graph traversal from the pattern specified
      # in a `MATCH` clause.
      #
      # @see http://neo4j.com/docs/stable/query-start.html
      #
      def self.start(*conditions)
        @traversal[:start] = conditions
      end

      # Specify a `MATCH` clause for the relation's graph traversal. If you’re
      # coming from the SQL world, you can think of this as similar to a
      # `SELECT FROM`, except that it matches on a topological structure rather
      # than a schema.
      #
      # @example Reproduce SQL style projections by passing node labels directly.
      #
      #   class Movies < ROM::Relation[:neo4j]
      #     matches m: :movie
      #   end
      #
      # @example Specify topological matches using Cypher's ASCII-art syntax.
      #
      #   class Actors < ROM::Relation[:neo4j]
      #     matches '(actor:Person)-[:ACTED_IN]->(movie)'
      #   end
      #
      # @see http://neo4j.com/docs/stable/query-match.html
      #
      def self.matches(*conditions)
        @traversal[:match] = conditions
      end

      # Specify a `RETURN` clause for the relation. This will define the
      # structure of objects in the returned dataset.
      #
      # Any combination of nodes, edges and properties can be selected, as well
      # as custom aliases and distinct objects.
      #
      # @see http://neo4j.com/docs/stable/query-return.html
      #
      def self.returns(*conditions)
        @traversal[:return] = conditions
      end

    end

  end
end
