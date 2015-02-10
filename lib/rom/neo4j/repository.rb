module ROM

  module Neo4j

    class Repository < ROM::Repository

      def initialize(uri, options={})
        @connection = ::Neo4j::Session.open(:server_db, uri, options)
      end

      def dataset(name)
        binding = { n: Inflecto.singularize(name).capitalize.to_sym }
        traversal = @connection.query
        Dataset.new(binding, traversal)
      end

      def dataset?(name)
        # TODO: need to figure out what this means in the context of a graph
        true
      end

    end
  end
end
