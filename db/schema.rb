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

ActiveRecord::Schema.define(version: 20171116070345) do

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "team_id", null: false, comment: "团队 ID"
    t.integer "user_id", null: false, comment: "用户 ID"
    t.integer "project_id", null: false, comment: "项目 ID"
    t.integer "eventable_id", null: false, comment: "事件对象 id"
    t.string "eventable_type", limit: 191, null: false, comment: "事件对象"
    t.string "content", comment: "事件内容"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_events_on_project_id"
    t.index ["team_id"], name: "index_events_on_team_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name", limit: 191, null: false
    t.string "safe_code", limit: 191, null: false
    t.integer "user_id", null: false, comment: "用户 ID"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["safe_code"], name: "index_projects_on_safe_code", unique: true
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name", limit: 191, null: false
    t.string "safe_code", limit: 191, null: false
    t.integer "user_id", null: false, comment: "用户 ID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["safe_code"], name: "index_teams_on_safe_code", unique: true
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "user_projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "user_id", null: false, comment: "用户 ID"
    t.integer "project_id", null: false, comment: "项目 ID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_user_projects_on_project_id"
    t.index ["user_id"], name: "index_user_projects_on_user_id"
  end

  create_table "user_teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "user_id", null: false, comment: "用户 ID"
    t.integer "team_id", null: false, comment: "团队 ID"
    t.integer "power", null: false, comment: "权限"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_user_teams_on_team_id"
    t.index ["user_id"], name: "index_user_teams_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "nickname", limit: 191, comment: "昵称"
    t.string "avatar_url", comment: "头像"
    t.string "user_key", limit: 50, null: false, comment: "UserKey"
    t.string "email", limit: 191, null: false, comment: "邮箱"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["user_key"], name: "index_users_on_user_key", unique: true
  end

end
