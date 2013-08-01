# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reek-checkstyle-formatter/version'

s = Gem::Specification.new

s.name          = "reek-checkstyle-formatter"
s.version       = Reek::CheckstyleFormatter::VERSION
s.authors       = ["Ruben Jenster"]
s.email         = ["r.jenster@drachenfels.de"]
s.description   = %q{Checkstyle formatter for reek}
s.summary       = %q{Checkstyle formatter for reek}
s.homepage      = "http://github.com/Drachenfels-GmbH/reek-checkstyle-formatter"

s.files         = `git ls-files`.split($/)
s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
s.test_files    = s.files.grep(%r{^(test|spec|features)/})
s.require_paths = ["lib"]

s.add_development_dependency "rake"
s.add_development_dependency "simplecov"
s.add_development_dependency "simplecov-rcov"

s.add_dependency 'reek'

s

