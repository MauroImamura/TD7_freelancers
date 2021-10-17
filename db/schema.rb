# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_17_191812) do

  create_table "applications", force: :cascade do |t|
    t.string "description"
    t.decimal "payment"
    t.integer "time_per_week"
    t.datetime "expected_deadline"
    t.integer "job_id", null: false
    t.integer "worker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 5
    t.index ["job_id"], name: "index_applications_on_job_id"
    t.index ["worker_id"], name: "index_applications_on_worker_id"
  end

  create_table "favorite_workers", force: :cascade do |t|
    t.boolean "checked"
    t.integer "user_id", null: false
    t.integer "worker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_favorite_workers_on_user_id"
    t.index ["worker_id"], name: "index_favorite_workers_on_worker_id"
  end

  create_table "favorited_workers", force: :cascade do |t|
    t.boolean "checked", default: false
    t.integer "user_id", null: false
    t.integer "worker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_favorited_workers_on_user_id"
    t.index ["worker_id"], name: "index_favorited_workers_on_worker_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "skills"
    t.decimal "payment"
    t.datetime "deadline"
    t.boolean "in_person"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 10
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "user_feedbacks", force: :cascade do |t|
    t.integer "rate"
    t.string "comment"
    t.integer "user_id", null: false
    t.integer "worker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "job_id", null: false
    t.index ["job_id"], name: "index_user_feedbacks_on_job_id"
    t.index ["user_id"], name: "index_user_feedbacks_on_user_id"
    t.index ["worker_id"], name: "index_user_feedbacks_on_worker_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "worker_feedbacks", force: :cascade do |t|
    t.integer "rate"
    t.string "comment"
    t.integer "user_id", null: false
    t.integer "worker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "application_id", null: false
    t.index ["application_id"], name: "index_worker_feedbacks_on_application_id"
    t.index ["user_id"], name: "index_worker_feedbacks_on_user_id"
    t.index ["worker_id"], name: "index_worker_feedbacks_on_worker_id"
  end

  create_table "workers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "full_name"
    t.string "social_name"
    t.datetime "birth_date"
    t.string "education"
    t.string "description"
    t.string "experience"
    t.index ["email"], name: "index_workers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_workers_on_reset_password_token", unique: true
  end

  add_foreign_key "applications", "jobs"
  add_foreign_key "applications", "workers"
  add_foreign_key "favorite_workers", "users"
  add_foreign_key "favorite_workers", "workers"
  add_foreign_key "favorited_workers", "users"
  add_foreign_key "favorited_workers", "workers"
  add_foreign_key "jobs", "users"
  add_foreign_key "user_feedbacks", "jobs"
  add_foreign_key "user_feedbacks", "users"
  add_foreign_key "user_feedbacks", "workers"
  add_foreign_key "worker_feedbacks", "applications"
  add_foreign_key "worker_feedbacks", "users"
  add_foreign_key "worker_feedbacks", "workers"
end
