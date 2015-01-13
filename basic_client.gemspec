# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'basic_client/version'

Gem::Specification.new do |spec|
  spec.name          = "basic_client"
  spec.version       = BasicClient::VERSION
  spec.authors       = ["Jason Kriss"]
  spec.email         = ["jasonkriss@gmail.com"]
  spec.summary       = %q{Helper library for writing faraday-based API wrappers.}
  spec.homepage      = "https://github.com/jasonkriss/basic_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '~> 0.8.9'
  spec.add_dependency 'faraday_middleware', '~> 0.9.1'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
