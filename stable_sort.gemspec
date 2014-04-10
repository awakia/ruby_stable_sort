# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stable_sort/version'

Gem::Specification.new do |spec|
  spec.name          = "stable_sort"
  spec.version       = StableSort::VERSION
  spec.authors       = ["Naoyoshi Aikawa"]
  spec.email         = ["n.aikawa91@gmail.com"]
  spec.description   = %q{Add stable sort functionality to ruby}
  spec.summary       = %q{Add stable_sort and stable_sort_by to Array and Enumerator.}
  spec.homepage      = "https://github.com/awakia/ruby_stable_sort"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "coveralls"
end
