class Attendance < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :days, dependent: :destroy
end
