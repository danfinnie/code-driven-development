# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'code_driven_development/version'

Gem::Specification.new do |spec|
  spec.name          = "code_driven_development"
  spec.version       = CodeDrivenDevelopment::VERSION
  spec.authors       = ["Dan Finnie"]
  spec.email         = ["dan@danfinnie.com"]
  spec.description   = %q{Automatically generate stubby tests from your implementation.}
  spec.summary       = %q{Ever see a test and think, "wow, this test cares a lot about the exact abstract syntax tree of the code?" CDD aims to generate tests like that.}
  spec.homepage      = "https://github.com/danfinnie/code-driven-development"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ruby_parser"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
end
