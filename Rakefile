require 'rspec/core/rake_task'

load 'neo4j/tasks/neo4j_server.rake'

def jar_path
  spec = Gem::Specification.find_by_name('neo4j-community')
  gem_root = spec.gem_dir
  gem_root + '/lib/neo4j-community/jars'
end

RSpec::Core::RakeTask.new(:spec)
task default: [:ci]

desc 'Run CI tasks'
task ci: [:spec]

