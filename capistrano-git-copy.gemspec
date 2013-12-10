# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/git/copy/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-git-copy"
  spec.version       = Capistrano::Git::Copy::VERSION
  spec.authors       = ["Florian Schwab"]
  spec.email         = ["me@ydkn.de"]
  spec.description   = %q{Copy local git repository deploy strategy for capistrano}
  spec.summary       = %q{Copy local git repository deploy strategy for capistrano}
  spec.homepage      = "https://github.com/ydkn/capistrano-git-copy"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'capistrano', '>= 3.0.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
