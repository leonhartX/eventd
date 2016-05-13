module ApplicationHelper
  def login! user
    login_as(user, :scope => :user)
  end

  def auth_type
  	current_user.provider ? "oauth" : "none"
  end
end