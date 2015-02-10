require 'rom/support/array_dataset'

module ROM
  module Neo4j
    # A dataset represents a collection of objects returned from a traversal
    # over a sub-graph.
    #
    # Datasets are Enumerable objects and can be manipulated using the standard
    # methods, `each`, `map`, `inject`, and so forth.
    class Dataset
      include ArrayDataset

      def initialize(binding, traversal)
        @binding = binding
        @traversal = traversal
      end

      def to_cypher
        @traversal.to_cypher
      end

      def to_a
        @traversal.to_a
      end

      def each(&iter)
        to_a.each(&iter)
      end

      def where(conditions)
        @traversal.where(n: conditions)
      end

    end

  end
end
