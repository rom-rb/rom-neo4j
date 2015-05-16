require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task default: [:ci]

desc 'Run CI tasks'
task ci: [:spec]

task :disable_auth do
  puts "Disabling server auth for: #{ENV['NEO4J_VERSION']}"

  auth_properties = [
    'dbms.security.authorization_enabled=true',
    'dbms.security.auth_enabled=true'
  ]

  properties = "neo4j-community-#{ENV['NEO4J_VERSION']}/config/neo4j-server.properties"

  config_source = File.read(properties)

  auth_properties.each do |prop|
    config_source.gsub!(prop, prop.gsub('=true', '=false'))
  end

  File.open(properties, 'w') do |f| 
  	f.puts(config_source)
  end
end
