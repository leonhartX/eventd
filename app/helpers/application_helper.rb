module ApplicationHelper
  def login! user
    login_as(user, :scope => :user)
  end

  def involved? attendance
	attendance.state 	
  end

  def attending? attendance
	attendance.state != 2  	
  end
end