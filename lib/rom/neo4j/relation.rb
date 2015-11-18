module ROM
  module Neo4j
    # Relation supporting Cypher graph traversals. Configure the sub-graph
    # for the relation using the Cypher Query DSL from 
    # for mapping by specifying nodes, edges and properties in the `returns`.
    class Relation < ROM::Relation
      adapter :neo4j

      # TODO: provide reference to Neo4j Cypher DSL docs?
      forward *%i[
        break create create_unique delete limit match merge on_create_set
        on_match_set optional_match order remove return set start union_cypher
        unwind using where with
      ]

      # TODO support passing raw Cypher here-- current holdup is that query
      # objects created with raw Cypher give a Node/Rel enumerator, which is
      # different than the hash enumerator we want
      def self.cypher(&cypher_dsl)
        dataset(&cypher_dsl)
      end

      # The row iterator. Calling this kicks off the actual query to the
      # database server.
      def each(&iter)
        @dataset.each(&iter)
      end

    end

  end
end
