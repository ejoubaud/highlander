module PayloadAdapters

  class TwitterMention < Base

    def user
      @user ||= Services::Twitter.find_by_username(twitter_username).try(:user)
    end

    def tweet_id
      payload[:tweet_id]
    end

    def twitter_username
      payload[:twitter_username]
    end

    def text
      payload[:text]
    end

    def keyword_list
      payload[:keyword_list].to_s.split(",").collect(&:strip)
    end

    private

    def value
      return 10 if content.high_value?
    end

    def content
      @content ||= TweetContent.new(text, keyword_list)
    end

  end

end
