source 'https://rubygems.org'

# Specify your gem's dependencies in tweet_validator.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.5.0")
  # NOTE: unparser v0.3.0+ requires Ruby 2.5+
  gem "unparser", "< 0.3.0"
end
