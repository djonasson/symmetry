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
  s.summary     = %q{Symmetry gives you a simple way of creating symmetric
    has_and_belongs_to_many relationships (friendships, neighbors, etc.) in
    your Active Record models.}
  s.description = %q{Symmetry gives you a simple way of creating symmetric
    has_and_belongs_to_many relationships (friends, neighbors, etc.) in your
    Active Record models. More information can be found at:
    https://github.com/djonasson/worldwise}

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile",
    "README.rdoc"]

  s.add_dependency "rails", "~> 5.0"
end
