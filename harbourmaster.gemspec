$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "harbourmaster/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "harbourmaster"
  s.version     = Harbourmaster::VERSION
  s.authors     = ["Isaac Norman"]
  s.email       = ["idn@papercloud.com.au"]
  s.homepage    = "https://github.com/Papercloud/Harbourmaster"
  s.summary     = "Take control of your doc(k)s"
  s.description = "Rails generator for making documented API controllers"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.0.0", "<= 4.3.0"
  s.add_dependency "rspec-rails", "~> 3.2.1"
  s.add_dependency "active_model_serializers", "~> 0.9.3"
  s.add_dependency "rspec_api_documentation", "4.3.0"
  s.add_dependency "inherited_resources", '~> 1.6.0'
  s.add_dependency "responders", "~> 2.1.0"
  s.add_dependency "ragamuffins", "~> 1.0.5"
  s.add_dependency "paginative", "<= 0.3.0"
  s.add_dependency "ransack", "~> 1.6.4"
  s.add_dependency "apitome", "~> 0.0.8"
  s.add_dependency "factory_girl_rails"


  s.add_development_dependency "sqlite3"
end
