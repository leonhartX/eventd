module ApplicationHelper
  def login! user
    login_as(user, :scope => :user)
  end

end