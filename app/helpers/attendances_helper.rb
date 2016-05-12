module AttendancesHelper
  def action_type attendance
    attendance.state == nil ? "create" : "update"
  end
end
