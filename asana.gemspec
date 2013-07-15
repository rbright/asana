# -*- encoding: utf-8 -*-
require File.expand_path('../lib/asana/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryan Bright"]
  gem.email         = ["ryan@rbright.net"]
  gem.description   = %q{Ruby wrapper for the Asana REST API}
  gem.summary       = %q{Ruby wrapper for the Asana REST API}
  gem.homepage      = "http://github.com/rbright/asana"
  gem.license       = 'MIT'

  gem.add_dependency 'activeresource', '~> 3.2.3'

  gem.add_development_dependency 'guard-minitest', '~> 1.0.0'
  gem.add_development_dependency 'minitest', '~> 2.12.1'
  gem.add_development_dependency 'rake', '~> 0.9.2.2'
  gem.add_development_dependency 'vcr', '~> 2.1.0'
  gem.add_development_dependency 'webmock', '~> 1.8.6'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "asana"
  gem.require_paths = ["lib"]
  gem.version       = Asana::VERSION
end
