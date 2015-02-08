require 'rom/support/array_dataset'

module Neo4j
  module Core
    module QueryClauses

      class ReturnClause < Clause

        def from_key_and_value(key, value)
          case value
          when Array
            value.map do |v|
              from_key_and_value(key, v)
            end.join(', ')
          when String, Symbol
            # `row_proc` expects aliased properties not full paths
            # eg: 'title' rather than 'n.title'
            "#{key}.#{value} AS #{value}"
          else
            fail ArgError, value
          end
        end

      end

    end
  end
end

module ROM
  module Neo4j

    class Dataset
      include ArrayDataset

      def initialize(binding, traversal)
        @binding = binding
        @traversal = traversal
      end

      def map_properties(properties = [])
        @properties = properties
      end

      def to_a
        @traversal.return(n: @properties).to_a
      end

      def each(&iter)
        to_a.each(&iter)
      end

      def where(conditions)
        Dataset.new(@binding, @traversal.where(n: conditions))
      end

    end

  end
end
