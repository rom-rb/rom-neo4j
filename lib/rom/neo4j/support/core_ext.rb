# Extensions to the Neo4j::Core library making it easier to integrate with ROM.
module Neo4j
  module Core
    # DSL for generating Cypher queries and enumerating their results
    #
    # @see http://www.rubydoc.info/gems/neo4j-core/Neo4j/Core/Query
    class Query
      # def each
      #   response = self.response
      #   if response.is_a?(Neo4j::Server::CypherResponse)
      #     response.to_node_enumeration
      #   else
      #     Neo4j::Embedded::ResultWrapper.new(response, to_cypher)
      #   end.each { |object| yield object }
      # end
    end
  end
  module Server
    class CypherResponse
      # Coerces result objects from structs to hashes in results. 
      class HashEnumeration
        def each(&block)
          @response.each_data_row do |row|
            yield(row.each_with_index.each_with_object(struct.new) do |(value, i), result|
              result[columns[i].to_sym] = value
            end.to_h)
          end
        end
      end
      # Coerces result objects from structs to hashes in results. 
      def to_node_enumeration(cypher = '', session = Neo4j::Session.current)
        Enumerator.new do |yielder|
          @result_index = 0
          to_struct_enumeration(cypher).each do |row|
            @row_index = 0
            yielder << row.each_pair.each_with_object(@struct.new) do |(column, value), result|
              result[column] = map_row_value(value, session)
              @row_index += 1
            end.to_h
            @result_index += 1
          end
        end
      end
    end
  end
end
