class CreateAbsent < ActiveRecord::Migration[5.2]
  def change
    create_table :absents do |t|
      t.string :name, null: false, default: ''
      t.string :when, null: false, default: ''
      t.string :reason, null: false, default: ''
    end
  end
end
