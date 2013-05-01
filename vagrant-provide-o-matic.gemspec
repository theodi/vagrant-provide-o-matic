# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-provide-o-matic/version'

Gem::Specification.new do |gem|
  gem.name          = "vagrant-provide-o-matic"
  gem.version       = Vagrant::ProvideOMatic::VERSION
  gem.authors       = ["Sam Pikesley"]
  gem.email         = ["sam.pikesley@theodi.org"]
  gem.description   = %q{}
  gem.summary       = %q{}
  gem.homepage      = "https://github.com/theodi/vagrant-provide-o-matic"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "pry-debugger"
  gem.add_development_dependency "bundler", "~> 1.3"
end