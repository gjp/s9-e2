# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "colony/version"

Gem::Specification.new do |s|
  s.name        = "colony"
  s.version     = Colony::VERSION
  s.authors     = ["Gregory Parkhurst"]
  s.email       = ["six.impossible@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A cooperative console game involving giant insects.}
  s.description = %q{Please see the README}

  s.rubyforge_project = "colony"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
