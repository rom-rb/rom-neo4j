module ROM

  module Neo4j

    class Repository < ROM::Repository
      attr_reader :sets

      def initialize(uri, options={})
        @connection = ::Neo4j::Session.open(:server_db, uri, options)
        @sets = {}
      end

      def dataset(name)
        sets[name] = Dataset.new(@connection.query)
      end

      def dataset?(name)
        sets.key?(name)
      end

    end
  end
end
