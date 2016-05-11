module ApplicationHelper
  include Devise::TestHelpers
  def login! user
    login_as(user, :scope => :user)
  end
end