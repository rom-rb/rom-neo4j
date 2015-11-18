require 'rom/gateway'

module ROM
  module Neo4j
    class Gateway < ROM::Gateway

      def initialize(uri=nil, options={})
        @connection = ::Neo4j::Session.open(:server_db, uri, options)
      end

      def dataset(spec)
        %i[ start match return ].reduce(@connection.query) do |query, clause|
          spec[clause] ? query.send(clause, spec[clause] : query
        end
      end

    end
  end
end
