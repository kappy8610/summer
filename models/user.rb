class User < ActiveRecord::Base
  has_many :absents
  has_many :attendances, through: :attendance_users
  has_many :attendance_users
  belongs_to :belong
  
  def belong
    Belong.find(belong_id)
  end

end
