class CreateAttendances < ActiveRecord::Migration[5.2]  
  def change
    create_table :attendances do |t|
      t.belongs_to :user, index: true
      t.integer :day_at
      t.integer :month_at
      t.integer :year_at
      t.boolean :is_attendance ,null: false, default: false
    end
  end
end
