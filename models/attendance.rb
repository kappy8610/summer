class Attendance < ActiveRecord::Base
  has_many :users, through: :attendance_users
  has_many :attendance_users
end
