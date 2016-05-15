class TwitterClient
  def initialize user
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CLIENT_ID"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = user.token
      config.access_token_secret = user.secret
    end
  end

  def share message
    @client.update message
  end
end
