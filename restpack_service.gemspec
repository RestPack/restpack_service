# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'restpack_service/version'

Gem::Specification.new do |spec|
  spec.name          = "restpack_service"
  spec.version       = RestPack::Service::VERSION
  spec.authors       = ["Gavin Joyce"]
  spec.email         = ["gavinjoyce@gmail.com"]
  spec.description   = %q{RestPack service base}
  spec.summary       = %q{A base for RestPack services}
  spec.homepage      = "https://github.com/RestPack"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mutations",            "~> 0.7"
  spec.add_dependency "yajl-ruby",            "~> 1.2"
  spec.add_dependency "protected_attributes", "~> 1.0"
  spec.add_dependency "require_all",          "~> 1.3"
  spec.add_dependency "restpack_serializer",  "~> 0"
  spec.add_dependency "restpack_gem",         "~> 0"
  spec.add_dependency "modularize",           "~> 0"
  spec.add_dependency "sinatra",              "~> 1.4"
  spec.add_dependency "pg",                   "~> 0.17"
  spec.add_dependency "sidekiq",              "~> 3.2"

  spec.add_development_dependency "bundler",  "~> 1.3"
  spec.add_development_dependency "rake",     "~> 10"
  spec.add_development_dependency "rspec",    "~> 3"
  spec.add_development_dependency "bump",     "~> 0"
end
