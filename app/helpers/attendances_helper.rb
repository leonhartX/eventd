module AttendancesHelper
  def action_type attendance
  	return "none" unless attendance
    attendance.state == nil ? "create" : "update"
  end

  def involve_type attendance
  	return "Absent" if attendance.attending?
  	"Attend" + (attendance.event.over_capacity? ? " as waiter" : "")
  end
end
