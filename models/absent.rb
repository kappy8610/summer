class Absent < ActiveRecord::Base
  has_one :user, dependent: :destroy
  has_one :day, dependent: :destroy
end
