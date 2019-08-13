class User < ActiveRecord::Base
  belongs_to :attendance
  belongs_to :absent
  belongs_to :belong
end
