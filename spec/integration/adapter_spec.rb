require 'spec_helper'

require 'rom/lint/spec'

describe 'Neo4j adapter' do
  subject(:rom) { setup.finalize }

  let(:dsn) { 'http://localhost:7474' }
  let(:setup) { ROM.setup(:neo4j, dsn) }

  before do

    setup.relation(:movies) do
      def by_title(title)
        where(title: title)
      end
    end

    setup.mappers do
      define(:movies) do
        model name: 'Node'

        attribute :title
        attribute :released
        attribute :tagline
      end
    end
  end

  describe 'env#read' do
    it 'returns mapped object' do
      matrix = rom.read(:movies).by_title('The Matrix').first

      expect(matrix.title).to eql('The Matrix')
    end
  end
end