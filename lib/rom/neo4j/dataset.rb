require 'rom/support/array_dataset'

module ROM
  module Neo4j
    # A dataset represents a collection returned from a traversal over a sub-graph.
    #
    # Datasets are Enumerable objects and can be manipulated using the standard
    # methods, `each`, `map`, `inject`, and so forth.
    class Dataset
      include ArrayDataset # TODO: can this be removed?

      def initialize(name, traversal)
        @name = name
        @traversal = traversal
      end

      def to_cypher
        @traversal.to_cypher
      end

      def to_a
        @traversal = @traversal.return(@return_structure) if @return_structure
        @traversal.to_a
      end

      def each(&iter)
        to_a.each(&iter)
      end

      def where(conditions)
        anchor_traversal
        @traversal = @traversal.where(conditions)
        self
      end

      def graph_start_node(args)
        @start_node = args
      end

      def graph_match_anchor(*args)
        @match_anchor = args
      end

      def graph_return_structure(*args)
        @return_structure = args
      end

      def anchor_traversal
        return if @anchored
        @traversal = @traversal.start(@start_node) if @start_node
        @traversal = @traversal.match(@match_anchor) if @match_anchor
        @anchored = true
      end

    end

  end
end
