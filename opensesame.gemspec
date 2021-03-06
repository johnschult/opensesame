$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "open_sesame/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "opensesame"
  s.version     = OpenSesame::VERSION
  s.authors     = ["Ross Kaffenberger"]
  s.email       = ["rosskaff@gmail.com"]
  s.homepage    = "https://github.com/rossta/opensesame"
  s.summary     = "Rails engine for authenticating internal applications and private-access products"
  s.description = "Rails engine for authenticating internal applications and private-access products"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.1"
  s.add_dependency "bootstrap-sass", "~> 2.0.1"
  s.add_dependency "opensesame-github"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.9.0"
  s.add_development_dependency "capybara"
  s.add_development_dependency "launchy"
end
