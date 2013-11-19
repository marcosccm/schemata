# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schemata/version'

Gem::Specification.new do |spec|
  spec.name          = "schemata"
  spec.version       = Schemata::VERSION
  spec.authors       = ["Marcos Matos"]
  spec.email         = ["marcosccm@gmail.com"]
  spec.description   = %q{another schema generator}
  spec.summary       = %q{another schema generator}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "json"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
