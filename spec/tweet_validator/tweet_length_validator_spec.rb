describe TweetValidator::TweetLengthValidator do
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
end
