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

ActiveRecord::Schema[7.1].define(version: 2024_03_28_162857) do
  create_table "doctors", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "crm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_doctors_on_user_id"
  end

  create_table "patient_questions", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_patient_questions_on_patient_id"
    t.index ["question_id"], name: "index_patient_questions_on_question_id"
  end

  create_table "patients", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.integer "sex"
    t.decimal "creatinine", precision: 10
    t.integer "race"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "questions", charset: "utf8mb3", force: :cascade do |t|
    t.string "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "doctors", "users"
  add_foreign_key "patient_questions", "patients"
  add_foreign_key "patient_questions", "questions"
  add_foreign_key "patients", "users"
end
