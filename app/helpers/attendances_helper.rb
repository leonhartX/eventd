module AttendancesHelper
  def action_type attendance
  	return "none" unless attendance
    attendance.state == nil ? "create" : "update"
  end
end
