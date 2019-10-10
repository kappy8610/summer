class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.belongs_to :absent, index: true
      t.belongs_to :attendance, index: true
      t.belongs_to :belong, index: true
      t.string :name, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :password, null: false, default: ''
      t.string :input_password, null: false, default: ''
      t.integer:attendance_num ,null: false, default: 0
    end
  end
end
