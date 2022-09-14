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

ActiveRecord::Schema[7.0].define(version: 2022_09_12_185514) do
    create_table "estimations", force: :cascade do |t|
      t.string "first_name"
      t.boolean "first_time"
      t.integer "home_changes"
      t.integer "rentals_mortgages"
      t.boolean "professional_company_activity"
      t.integer "real_state_trade"
      t.boolean "with_couple"
      t.boolean "approved"
      t.boolean "paid"
      t.string "email"
      t.string "phone"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.float "price"
      t.integer "income_rent"
      t.integer "shares_trade"
      t.boolean "outside_alava"
    end
  end
  