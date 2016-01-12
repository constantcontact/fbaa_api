# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fbaa_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'fbaa_api'
  spec.version       = FbaaApi::VERSION
  spec.authors       = ['Jarrod Spillers']
  spec.email         = ['jspillers@constantcontact.com']

  spec.summary       = %q{API client for facebook ads adapter}
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/constantcontact/fbaa_api'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 10.4.2'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'pry', '~> 0.10.1'
  spec.add_development_dependency 'webmock', '~> 1.22.6'
  spec.add_development_dependency 'vcr', '~> 2.9.3'
  spec.add_development_dependency 'dotenv', '~> 2.0.2'

  spec.add_dependency 'rspec_junit_formatter', '0.2.2'
  spec.add_dependency 'rest-client', '~> 1.8.0'
  spec.add_dependency 'api-auth', '~> 1.4.1'
  spec.add_dependency 'json', '~> 1.8.3'
end
