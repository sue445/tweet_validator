module TweetValidator
  require "active_model"
  require "uri"

  class TweetLengthValidator < ActiveModel::EachValidator
    TWEET_MAX_LENGTH = 140

    def validate_each(record, attribute, value)
      record.errors.add(attribute, :invalid_tweet) unless TweetLengthValidator.valid_tweet?(value)
    end

    def self.valid_tweet?(tweet)
      return false unless tweet
      return false if tweet.empty?
      return false unless shorten_url_length(sanitize(tweet)) <= TWEET_MAX_LENGTH

      true
    end

    def self.sanitize(tweet)
      tweet.gsub(/%<.+?>/, "").gsub(/%{.+?}/, "")
    end

    def self.shorten_url_length(tweet)
      shorten_tweet = tweet.gsub(URI.regexp("http"), dummy_http_url).gsub(URI.regexp("https"), dummy_https_url)
      shorten_tweet.length
    end

    private_class_method

    def self.dummy_http_url
      dummy_url("http://", TweetValidator.config.short_url_length)
    end

    def self.dummy_https_url
      dummy_url("https://", TweetValidator.config.short_url_length_https)
    end

    def self.dummy_url(prefix, max_length)
      prefix + "x" * (max_length - prefix.length)
    end
  end
end
