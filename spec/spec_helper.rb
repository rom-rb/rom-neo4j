require 'rom-neo4j'
require 'webmock'
require 'vcr'

def server_url_config
  ENV['NEO4J_URL'] || 'http://localhost:7474'
end

def basic_auth_config
  { basic_auth: { username: 'neo4j', password: 'neo4j' } }
end

def rom_neo4j_setup
  if ENV['NEO4J_VERSION'] == '2.2.0'
    ROM.setup(:neo4j, server_url_config, basic_auth_config)
  else
    ROM.setup(:neo4j, server_url_config)
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/neo4j_server'
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
end
