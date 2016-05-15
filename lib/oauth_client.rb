class OauthClient
  def initialize user, klass = nil
    klass ||= "#{user.provider}".capitalize + "Client"
    klazz = Object.const_get klass
    @proxy = klazz.new user
  end

  def share message
    @proxy.share message
  end
end