# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tweet_validator/version'

Gem::Specification.new do |spec|
  spec.name          = "tweet_validator"
  spec.version       = TweetValidator::VERSION
  spec.authors       = ["sue445"]
  spec.email         = ["sue445@sue445.net"]
  spec.summary       = %q{tweet length check validator}
  spec.description   = %q{tweet length check validator}
  spec.homepage      = "https://github.com/sue445/tweet_validator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel"
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", ">= 1.7"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "railties"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "rspec-parameterized"
  spec.add_development_dependency "simplecov"
end
