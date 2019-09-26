class User < ActiveRecord::Base
  has_many :absents
  has_many :attendances, through: :attendance_users
  has_many :attendance_users
end
