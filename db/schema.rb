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

ActiveRecord::Schema.define(version: 20160127202655) do

  create_table "attachments", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.boolean  "has_image",         default: true
  end

  add_index "attachments", ["parent_type", "parent_id"], name: "index_attachments_on_parent_type_and_parent_id"

  create_table "courses", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "level",        limit: 255
    t.string   "number",       limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "credit_hours"
    t.boolean  "has_works",                default: false
  end

  create_table "images", force: :cascade do |t|
    t.integer  "work_id"
    t.integer  "parent_id"
    t.string   "content_type", limit: 255
    t.string   "filename",     limit: 255
    t.string   "thumbnail",    limit: 255
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instructors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_works",              default: false
  end

  create_table "other_files", force: :cascade do |t|
    t.integer  "work_id"
    t.integer  "parent_id"
    t.string   "content_type", limit: 255
    t.string   "filename",     limit: 255
    t.string   "thumbnail",    limit: 255
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_works", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "student_works", ["student_id"], name: "index_student_works_on_student_id"
  add_index "student_works", ["work_id"], name: "index_student_works_on_work_id"

  create_table "students", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "syllabi", force: :cascade do |t|
    t.string   "term"
    t.integer  "instructor_id"
    t.integer  "course_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  add_index "syllabi", ["course_id"], name: "index_syllabi_on_course_id"
  add_index "syllabi", ["instructor_id"], name: "index_syllabi_on_instructor_id"

  create_table "syllabus_files", force: :cascade do |t|
    t.string   "term"
    t.integer  "instructor_id"
    t.integer  "course_id"
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "works", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "term",            limit: 255
    t.text     "description"
    t.integer  "project_id"
    t.integer  "instructor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
    t.boolean  "has_attachments",             default: false
    t.boolean  "has_images",                  default: false
  end

end
