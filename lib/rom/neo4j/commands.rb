require 'rom/commands'

module ROM
  module Neo4j
    module Commands
      # Creates a new node
      #
      # Creates a new node in the graph with given properties. Any labels
      # configured on the command will also be applied to the node.
      #
      # @example
      #   class CreateCity < ROM::Commands::Create[:neo4j]
      #     input Hash
      #     labels :City
      #     result :one
      #   end
      #
      class CreateNode < ROM::Commands::Create
        defines :labels
        option :labels, reader: true

        def self.options
          super.merge!(labels: labels)
        end

        def execute(properties)
          node_args = [properties]
          node_args << [labels].flatten if labels

          create_node(*node_args)
        end

        def create_node(properties, labels)
          result = relation.dataset.session.create_node(properties, labels)
          result.props          
        end
      end

      # Alias of {CreateNode}
      #
      # @see ROM::Neo4j::Commands::CreateNode
      CreateVertex = Class.new(CreateNode)
    end
  end
end
