# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paper_trail/sinatra/version'

Gem::Specification.new do |spec|
  spec.name          = "paper_trail-sinatra"
  spec.version       = PaperTrail::Sinatra::VERSION
  spec.authors       = ["Jared Beck"]
  spec.email         = ["jared@jaredbeck.com"]

  spec.summary       = 'Sinatra support for paper_trail'
  spec.homepage      = 'https://github.com/jaredbeck/paper_trail-sinatra'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # At this time, there is no released version of sinatra
  # that is compatible with AR 5.
  spec.add_dependency "activesupport", [">= 4.0", "< 5"]

  spec.add_dependency "bundler", "~> 1.13"
  spec.add_dependency "paper_trail", ">= 7"

  # Not compatible with sinatra 2 yet
  # https://github.com/airblade/paper_trail/issues/856
  spec.add_dependency "sinatra", "< 2"

  spec.add_development_dependency "rspec"
end
