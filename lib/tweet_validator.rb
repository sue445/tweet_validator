require "tweet_validator/version"
require "tweet_validator/config"
require "tweet_validator/tweet_length_validator"
require 'tweet_validator/railtie' if defined?(Rails)

module TweetValidator
  def self.config
    TweetValidator::Config.config
  end
end
