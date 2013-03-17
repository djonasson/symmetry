$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "symmetry/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "symmetry"
  s.version     = Symmetry::VERSION
  s.authors     = ["Daniel Jonasson"]
  s.email       = ["daniel@guadeo.com"]
  s.homepage    = "https://github.com/djonasson/symmetry"
  s.summary     = %q{}
  s.description = %q{}

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile",
    "README.rdoc"]

  s.add_dependency "rails", ">= 3.1.0"
end
