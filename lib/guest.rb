class Guest

  def initialize
    @user = User.new
  end

  def method_missing(method, *args)
    return nil if @user.respond_to? (method)
    super
  end
end
