class CreateAdmin < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :name, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :password, null: false, default: ''
    end
  end
end
