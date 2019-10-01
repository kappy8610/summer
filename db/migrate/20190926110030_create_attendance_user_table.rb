class CreateAttendanceUserTable < ActiveRecord::Migration[5.2]
  def change
    create_table :attendance_users do |t|
      t.references :user, foreign_key: true
      t.references :attendance, foreign_key: true
    end
  end
end
