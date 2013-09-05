module Integrations
  class TwitterIntegration < Base
    attribute :consumer_key, String
    attribute :consumer_secret, String
    attribute :oauth_token, String
    attribute :oauth_token_secret, String

    def execute
      tweets.each do |tweet|
        post_metric(:twitter_mention, tweet)
      end
    end

    def tweets
      (twitter_client.mentions_timeline || []).collect do |status|
        {
          tweet_id: status.id,
          text: status.text,
          twitter_username: status.user.screen_name,
          followers_count: status.user.followers_count
        }
      end
    end

    def twitter_client
      Twitter.configure do |c|
        c.consumer_key        = consumer_key
        c.consumer_secret     = consumer_secret
        c.oauth_token         = oauth_token
        c.oauth_token_secret  = oauth_token_secret
      end

      @twitter_client ||= Twitter::Client.new
    end

  end
end