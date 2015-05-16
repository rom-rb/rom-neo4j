require 'spec_helper'

describe 'Neo4j commands' do
  let(:setup) { ROM.setup(:neo4j, neo4j_server_url) }
  subject(:rom) { setup.finalize }
  subject(:cities) { rom.commands.cities }

  before do
    setup.commands(:cities) do
      define(:create_node) do
        input Hash
        labels :city
        result :one
      end
    end

    setup.relation(:cities)
  end

  context '#execute' do
    it 'creates a single node' do |example|
      #VCR.use_cassette(example.description) do
        result = cities.create_node.execute(name: 'Sydney')
        expect(result).to eq(name: 'Sydney')
      #end
    end
  end
end
