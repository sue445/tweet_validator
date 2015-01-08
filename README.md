# TweetValidator

tweet length check validator

[![Gem Version](https://badge.fury.io/rb/tweet_validator.svg)](http://badge.fury.io/rb/tweet_validator)
[![Build Status](https://travis-ci.org/sue445/tweet_validator.png?branch=master)](https://travis-ci.org/sue445/tweet_validator)
[![Dependency Status](https://gemnasium.com/sue445/tweet_validator.svg)](https://gemnasium.com/sue445/tweet_validator)
[![Code Climate](https://codeclimate.com/github/sue445/tweet_validator/badges/gpa.svg)](https://codeclimate.com/github/sue445/tweet_validator)
[![Coverage Status](https://img.shields.io/coveralls/sue445/tweet_validator.svg)](https://coveralls.io/r/sue445/tweet_validator)

## Requirements
ruby 2.0+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tweet_validator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tweet_validator

## Usage

```ruby
class Tweet < ActiveRecord::Base
  validates :message, tweet_length: true
end
```

### Not Rails

include `TweetValidator` manually

```ruby
class Tweet < ActiveRecord::Base
  include TweetValidator

  validates :message, tweet_length: true
end
```

## Specification
calculate the length excluding `%<〜>` and `%{〜}`

### Example
```ruby
tweet.message = "a" * 140
tweet.valid?
# => true

tweet.message = "a" * 141
tweet.valid?
# => false

tweet.message = "a" * 140 + "%{screen_name}"
tweet.valid?
# => true

# url length is calculated as t.co
"https://github.com/sue445/tweet_validator".length
# => 41

tweet.message = "a" * 110 + "http://github.com/sue445/tweet_validator"
tweet.valid?
# => true
```

## Configuration
```ruby
TweetValidator.config.short_url_length = 22
TweetValidator.config.short_url_length_https = 23
```

If `short_url_length` and `short_url_length_https` is changed, please set new value.

see. https://dev.twitter.com/rest/reference/get/help/configuration

## Changelog
[full changelog](https://github.com/sue445/tweet_validator/compare/v0.0.2...master)

### 0.0.2
[full changelog](https://github.com/sue445/tweet_validator/compare/v0.0.1...v0.0.2)

* check `t.co` url length
  * https://github.com/sue445/tweet_validator/pull/5

### 0.0.1
* first release

## Contributing

1. Fork it ( https://github.com/sue445/tweet_validator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
