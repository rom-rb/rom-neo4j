require 'rom-neo4j'
require 'webmock'
require 'vcr'

def neo4j_server_url
  ENV['NEO4J_URL'] || 'http://localhost:7474'
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/neo4j_server'
  config.hook_into :webmock
end
