module TweetValidator
  require "active_support/configurable"

  class Config
    include ActiveSupport::Configurable

    config_accessor :short_url_length
    config_accessor :short_url_length_https

    configure do |config|
      # via. https://dev.twitter.com/rest/reference/get/help/configuration
      config.short_url_length       = 22
      config.short_url_length_https = 23
    end
  end
end
