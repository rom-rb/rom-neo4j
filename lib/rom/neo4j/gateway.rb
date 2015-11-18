require 'rom/gateway'

module ROM
  module Neo4j
    class Gateway < ROM::Gateway

      def initialize(uri=nil, options={})
        @connection = ::Neo4j::Session.open(:server_db, uri, options)
      end

      def dataset(dataset)
        @connection.query
      end

    end
  end
end
