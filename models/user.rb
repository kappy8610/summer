class User < ActiveRecord::Base
  has_many :absents
  has_many :attendances
  belongs_to :belong
  
  def belong
    Belong.find(belong_id)
  end

  def attendance
    Attendance.find(attendance_id)
  end

end
