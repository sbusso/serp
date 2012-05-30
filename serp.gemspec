# -*- encoding: utf-8 -*-
require File.expand_path('../lib/serp/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Stephane Busso"]
  gem.email         = ["stephane.busso@gmail.com"]
  gem.description   = %q{Extract domains from google search engine results}
  gem.summary       = %q{Extract domains from google search engine results}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "serp"
  gem.require_paths = ["lib"]
  gem.version       = Serp::VERSION
  gem.add_runtime_dependency('nokogiri')
  gem.add_runtime_dependency('mechanize')
  # gem.add_development_dependency "rspec"
end
