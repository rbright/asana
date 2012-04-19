# -*- encoding: utf-8 -*-
require File.expand_path('../lib/asana/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryan Bright"]
  gem.email         = ["ryan@rbright.net"]
  gem.description   = %q{Ruby wrapper for the Asana REST API}
  gem.summary       = %q{Ruby wrapper for the Asana REST API}
  gem.homepage      = "http://github.com/rbright/asana"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "asana"
  gem.require_paths = ["lib"]
  gem.version       = Asana::VERSION
end
