require_relative "lib/stellarfy/version"

Gem::Specification.new do |spec|
  spec.name        = "stellarfy"
  spec.version     = Stellarfy::VERSION
  spec.authors     = ["Marcelo Biffara"]
  spec.email       = ["marcelo@pactta.com"]
  spec.homepage    = "https://github.com/Pactta/stellarfy"
  spec.summary     = "Stellarfy is a Rails engine with the necessary tools to interact with Stellar Anchors and Stellar Horizon API"
  spec.description = "Developed by the team at Pactta"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Pactta/stellarfy"
  spec.metadata["changelog_uri"] = "https://github.com/Pactta/stellarfy/tags"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "pg"
  spec.add_dependency "rails", ">= 7.0.4"  
  spec.add_dependency "interactor"
  spec.add_dependency "stellar-base"
  spec.add_dependency "stellar-sdk"
  spec.add_dependency "toml-rb"
  spec.add_dependency "httparty"
end
