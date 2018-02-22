# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paper_trail/sinatra/version'

Gem::Specification.new do |spec|
  spec.name          = "paper_trail-sinatra"
  spec.version       = ::PaperTrail::Sinatra::VERSION
  spec.authors       = ["Jared Beck"]
  spec.email         = ["jared@jaredbeck.com"]
  spec.licenses = ["GPL-3.0"]
  spec.summary       = 'Sinatra support for paper_trail'
  spec.homepage      = 'https://github.com/jaredbeck/paper_trail-sinatra'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # PT 7 requires ruby >= 2.1.0. We don't technically need the same constraint
  # in this project, but it's helpful for local development.
  spec.required_ruby_version = ">= 2.1.0"

  spec.add_dependency "activesupport", [">= 4.2", "< 6"]

  spec.add_dependency "bundler", "~> 1.13"

  # This gem should not be used with PT < 7 because both define
  # `::PaperTrail::Sinatra`.
  spec.add_dependency "paper_trail", [">= 7", "< 9"]

  spec.add_dependency "sinatra", [">= 1.0.0", "< 3"]
  spec.add_development_dependency "rack-test", "~> 0.6"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "sqlite3", "~> 1.3"
end
