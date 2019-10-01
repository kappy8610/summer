class CreateToday < ActiveRecord::Migration[5.2]
  def change
    create_table :todays do |t|
      t.integer :month_at ,null: false, default: 0
      t.integer :day_at ,null: false, default: 0
    end
  end
end
