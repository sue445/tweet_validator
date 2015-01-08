describe TweetValidator::TweetLengthValidator do
  let(:short_url_length)      { TweetValidator.config.short_url_length }
  let(:short_url_length_https){ TweetValidator.config.short_url_length_https }

  let(:model_class) do
    Struct.new(:message_template) do
      include ActiveModel::Validations
      include TweetValidator

      def self.name
        'Tweet'
      end

      validates :message_template, tweet_length: true
    end
  end

  describe "#validate" do
    subject{ model_class.new(message_template) }

    context "with valid tweet" do
      where(:message_template) do
        [
          ["a"],
          ["a" * 130 + "%<this_is_variable>"],
          ["a" * 130 + "%{this_is_variable}"],
          ["a" * 110 + "http://github.com/sue445/tweet_validator"],
          ["a" * 110 + "https://github.com/sue445/tweet_validator"],
        ]
      end

      with_them do
        it { should be_valid }
      end
    end

    context "with invalid tweet" do
      where(:message_template) do
        [
          [nil      ],
          [""       ],
          ["a" * 141],
        ]
      end

      with_them do
        it { should_not be_valid }
      end
    end

  end

  describe "#sanitize" do
    subject{ TweetValidator::TweetLengthValidator.sanitize(tweet) }

    where(:tweet, :expected) do
      [
        ["foo"       , "foo"],
        ["foo%<hoge>", "foo"],
        ["foo%{hoge}", "foo"],
        ["foo%{hoge}bar%{hoe}", "foobar"],
      ]
    end

    with_them do
      it { should eq expected }
    end

  end

  describe "#shorten_url_length" do
    subject{ TweetValidator::TweetLengthValidator.shorten_url_length(tweet) }

    where(:tweet, :shorten_length) do
      [
        ["github", 6],

        ["http://github.com/"                       , short_url_length],
        ["http://github.com/sue445/tweet_validator" , short_url_length],
        ["github http://github.com/"                , short_url_length + 7],

        ["https://github.com/"                      , short_url_length_https],
        ["https://github.com/sue445/tweet_validator", short_url_length_https],
        ["github https://github.com/"               , short_url_length_https + 7],
      ]
    end

    with_them do
      it { should eq shorten_length }
    end
  end
end
