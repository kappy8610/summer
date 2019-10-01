# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_30_011718) do

  create_table "absents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", default: "", null: false
    t.string "when", default: "", null: false
    t.string "reason", default: "", null: false
    t.index ["user_id"], name: "index_absents_on_user_id"
  end

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "password", default: "", null: false
  end

  create_table "attendance_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "attendance_id"
    t.index ["attendance_id"], name: "index_attendance_users_on_attendance_id"
    t.index ["user_id"], name: "index_attendance_users_on_user_id"
  end

  create_table "attendances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "attendance_users_id"
    t.integer "day_at"
    t.boolean "is_attendance", default: false, null: false
    t.index ["attendance_users_id"], name: "index_attendances_on_attendance_users_id"
  end

  create_table "belongs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", default: "", null: false
    t.index ["user_id"], name: "index_belongs_on_user_id"
  end

  create_table "todays", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "month_at", default: 0, null: false
    t.integer "day_at", default: 0, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "absent_id"
    t.bigint "attendance_users_id"
    t.bigint "belong_id"
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "password", default: "", null: false
    t.boolean "is_attendance", default: false, null: false
    t.integer "attendance_num", default: 0, null: false
    t.index ["absent_id"], name: "index_users_on_absent_id"
    t.index ["attendance_users_id"], name: "index_users_on_attendance_users_id"
    t.index ["belong_id"], name: "index_users_on_belong_id"
  end

  add_foreign_key "absents", "users"
  add_foreign_key "attendance_users", "attendances"
  add_foreign_key "attendance_users", "users"
end
