class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :user do |t|
      t.belongs_to :attendance, index: true
      t.belongs_to :belong, index: true
      t.string :name, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :password, null: false, default: ''
      t.boolean :is_attendance ,null: false
      t.integer:attendance_num ,null: false, default: 0
      t.integer:absent_num ,null: false, default: 0
      t.integer:sabotage_num ,null: false, default: 0
    end
  end

  def change
    create_table :day do |t|
      t.integer:year_at ,null: false, default: 0
      t.integer:month_at ,null: false, default: 0
      t.integer:day_at ,null: false, default: 0
      t.boolean :is_active ,null: false, default: false
    end
  end
  
  def change
    create_table :attendances do |t|
      t.string :name, null: false, default: ''
      t.boolean :is_attendance ,null: false, default: false
      t.boolean :is_attendance_contact ,null: false, default: false
    end
  end

end
