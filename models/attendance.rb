class Attendance < ActiveRecord::Base
  belongs_to :user

  def user
    User.find(user_id)
  end
end
