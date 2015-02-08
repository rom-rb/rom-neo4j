module ROM

  class Mapper
    def call(relation)
      # Duck-punchy hack, because I don't yet understand
      # how header/schema tuples get passed between the
      # mapper and relations.
      relation.map_properties(header.tuple_keys)

      transformer[relation.to_a]
    end
  end

  module Neo4j

    class Relation < ROM::Relation
    end

    class Repository < ROM::Repository

      def initialize(uri, options={})
        @connection = ::Neo4j::Session.open(:server_db, uri, options)
      end

      def dataset(name)
        binding = { n: Inflecto.singularize(name).capitalize.to_sym }
        traversal = @connection.query.match(binding)
        Dataset.new(binding, traversal)
      end

      def dataset?(name)
        true
      end

    end
  end
end
