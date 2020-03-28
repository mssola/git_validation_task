# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "git_validation/version"

Gem::Specification.new do |spec|
  spec.name          = "git_validation_task"
  spec.version       = GitValidation::VERSION
  spec.authors       = ["mssola"]
  spec.email         = ["mikisabate@gmail.com"]
  spec.description   = "A rake task for the git-validation tool"
  spec.summary       = "Rake integration for the git-validation tool."
  spec.homepage      = "https://github.com/mssola/git_validation_task"
  spec.license       = "LGPL-3.0"

  spec.files         = Dir["lib/**/*"] + Dir["*.md"] + Dir["COPYING*"] +
                       %w[Gemfile Rakefile git_validation_task.gemspec]
  spec.test_files    = spec.files.grep("^test/")
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3"

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "minitest", "~> 5.14.0"
  spec.add_development_dependency "rake", "~> 13.0.1"
  spec.add_development_dependency "rubocop", "~> 0.80.1"
  spec.add_development_dependency "rubocop-minitest", "~> 0.8.0"
end
