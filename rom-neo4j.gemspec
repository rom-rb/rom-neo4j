# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rom/neo4j/version'

Gem::Specification.new do |spec|
  spec.name          = 'rom-neo4j'
  spec.version       = ROM::Neo4j::VERSION.dup
  spec.authors       = ['Mark Rickerby']
  spec.email         = ['me@maetl.net']
  spec.summary       = 'Neo4j graph relations for Ruby Object Mapper'
  spec.description   = spec.summary
  spec.homepage      = 'https://rom-rb.org/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rom', '~> 0.8', '>= 0.8.0'
  spec.add_runtime_dependency 'neo4j-core', '4.0.1'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop', '~> 0.28.0'
end
