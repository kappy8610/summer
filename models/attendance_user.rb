class AttendanceUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :attendance

  def user
    User.find(user_id)
  end

  def attendance
    Attendance.find(attendance_id)
  end
end