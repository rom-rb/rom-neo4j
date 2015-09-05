require 'rom-neo4j'

def server_url_config
  ENV['NEO4J_URL'] || 'http://localhost:7474'
end

def basic_auth_config
  { basic_auth: { username: 'neo4j', password: 'neo4j' } }
end

def rom_neo4j_setup
  rom_env = ROM::Environment.new
  rom_env.use :auto_registration
  if ENV['NEO4J_VERSION'] == '2.2.0'
    rom_env.setup(:neo4j, server_url_config, basic_auth_config)
  else
    rom_env.setup(:neo4j, server_url_config)
  end
end
