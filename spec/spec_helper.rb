require 'rom-neo4j'

def server_username
  ENV['NEO4J_USERNAME'] || 'neo4j'
end

def server_password
  ENV['NEO4J_PASSWORD'] || 'neo4jrb rules, ok?'
end

def basic_auth_hash
  {
    username: server_username,
    password: server_password
  }
end

def server_url
  ENV['NEO4J_URL'] || 'http://localhost:7474'
end