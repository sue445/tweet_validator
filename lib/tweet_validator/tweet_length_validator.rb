module TweetValidator
  require "active_model"

  class TweetLengthValidator < ActiveModel::EachValidator
    TWEET_MAX_LENGTH = 140

    def validate_each(record, attribute, value)
      record.errors.add(attribute, :invalid_tweet) unless TweetLengthValidator.valid_tweet?(value)
    end

    def self.valid_tweet?(tweet)
      return false unless tweet
      return false if tweet.empty?
      return false unless sanitize(tweet).length <= TWEET_MAX_LENGTH

      true
    end

    def self.sanitize(tweet)
      tweet.gsub(/%<.+?>/, "").gsub(/%{.+?}/, "")
    end
  end
end
