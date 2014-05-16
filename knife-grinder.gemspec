# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knife/grinder/version'

Gem::Specification.new do |spec|
  spec.name          = "knife-grinder"
  spec.version       = Knife::Grinder::VERSION
  spec.authors       = ["Alexander Sologub"]
  spec.email         = ["alexsologoub@gmail.com"]
  spec.summary       = %q{Knife plugin for infrastructure management}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "chef"
  spec.add_dependency "knife-ec2"

  spec.add_development_dependency "chefspec"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
