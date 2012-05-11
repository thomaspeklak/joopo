# -*- encoding: utf-8 -*-
require File.expand_path('../lib/joopo/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Thomas Peklak"]
  gem.email         = ["thomas.peklak@gmail.com"]
  gem.description   = %q{A universal proxy for external apis.}
  gem.summary       = %q{This gem opens a server via Sinatra that can be used to proxy external apis. This is usefull for JavaScript development when you need to connect to a server that is not on your development domain.}
  gem.homepage      = "https://github.com/thomaspeklak/joopo"

  gem.required_ruby_version     = ">= 1.8.7"
  gem.required_rubygems_version = ">= 1.3.6"
  gem.rubyforge_project         = "joopo"

  gem.add_dependency(%q<sinatra>, ["~> 1.2"])

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "joopo"
  gem.require_paths = ["lib"]
  gem.version       = Joopo::VERSION
end
