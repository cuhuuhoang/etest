# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160524114101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "teacher_id"
    t.boolean  "closed",      default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "courses", ["teacher_id"], name: "index_courses_on_teacher_id", using: :btree

  create_table "do_tests", force: :cascade do |t|
    t.text     "answers"
    t.float    "current_score"
    t.float    "first_score"
    t.float    "highest_score"
    t.integer  "test_id"
    t.integer  "student_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "do_tests", ["student_id"], name: "index_do_tests_on_student_id", using: :btree
  add_index "do_tests", ["test_id"], name: "index_do_tests_on_test_id", using: :btree

  create_table "enrolls", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "enrolls", ["course_id"], name: "index_enrolls_on_course_id", using: :btree
  add_index "enrolls", ["student_id"], name: "index_enrolls_on_student_id", using: :btree

  create_table "file_uploads", force: :cascade do |t|
    t.string   "file"
    t.integer  "attachment_id"
    t.string   "attachment_type"
    t.string   "type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "file_uploads", ["attachment_type", "attachment_id"], name: "index_file_uploads_on_attachment_type_and_attachment_id", using: :btree

  create_table "new_student_courses", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "new_student_courses", ["course_id"], name: "index_new_student_courses_on_course_id", using: :btree
  add_index "new_student_courses", ["student_id"], name: "index_new_student_courses_on_student_id", using: :btree

  create_table "teaches", force: :cascade do |t|
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.integer  "requester_id"
    t.boolean  "is_accept",    default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "teaches", ["student_id"], name: "index_teaches_on_student_id", using: :btree
  add_index "teaches", ["teacher_id"], name: "index_teaches_on_teacher_id", using: :btree

  create_table "test_for_courses", force: :cascade do |t|
    t.boolean  "shown_answer", default: false
    t.datetime "open_date"
    t.integer  "test_id"
    t.integer  "course_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "test_for_courses", ["course_id"], name: "index_test_for_courses_on_course_id", using: :btree
  add_index "test_for_courses", ["test_id"], name: "index_test_for_courses_on_test_id", using: :btree

  create_table "tests", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "questions"
    t.text     "question_index"
    t.text     "answers"
    t.text     "answer_index"
    t.string   "type"
    t.integer  "time"
    t.integer  "teacher_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "tests", ["teacher_id"], name: "index_tests_on_teacher_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,         null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "full_name"
    t.string   "avatar"
    t.string   "skype"
    t.string   "facebook"
    t.string   "phone"
    t.string   "address"
    t.datetime "dob"
    t.string   "type",                   default: "Student"
    t.boolean  "is_admin",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
