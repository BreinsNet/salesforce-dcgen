# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dcgen/version'

Gem::Specification.new do |spec|
  spec.name          = "dcgen"
  spec.version       = Dcgen::VERSION
  spec.authors       = ["Juan Breinlinger"]
  spec.email         = ["<juan.brein@breins.net>"]
  spec.summary       = %q{dcgen will generate a destructiveChanges.xml comparing two source directories}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
