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

ActiveRecord::Schema.define(version: 20170716151125) do

  create_table "mem_calcs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "member_id"
    t.decimal  "value",      precision: 10, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "calc_type"
    t.index ["member_id"], name: "index_mem_calcs_on_member_id", using: :btree
  end

  create_table "members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.integer  "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "username"
  end

  create_table "runs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.float    "distance",   limit: 24
    t.integer  "duration"
    t.string   "title"
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.date     "date"
    t.integer  "member_id"
    t.integer  "days_late"
    t.index ["member_id"], name: "index_runs_on_member_id", using: :btree
  end

  create_table "team_calcs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.decimal  "value",      precision: 10, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_foreign_key "mem_calcs", "members"
  add_foreign_key "runs", "members"
end
