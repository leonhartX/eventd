class FacebookClient
  def initialize user
    @client = Koala::Facebook::API.new(user.token)
  end

  def share message
    @client.put_wall_post message
  end
end
