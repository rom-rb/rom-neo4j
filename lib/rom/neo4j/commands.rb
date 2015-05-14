require 'rom/commands'

module ROM
  module Neo4j
    module Commands
      class CreateNode < ROM::Commands::Create
        def execute(tuples)
          labels = [options[:input].name.to_sym]
          result = relation.dataset.session.create_node(tuples)
          result.props
        end
      end
    end
  end
end
