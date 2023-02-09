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

ActiveRecord::Schema.define(version: 2023_02_07_122923) do

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.date "task_date"
    t.text "task_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_urgent", default: false
    t.boolean "is_completed", default: false
    t.integer "custom_recur_frequency_number"
    t.integer "custom_recur_frequency_interval"
    t.integer "repeat_on"
    t.date "recurrence_start_date"
    t.date "recurrence_end_date"
    t.string "type_of_task"
    t.integer "recurrence_rate"
    t.integer "from_recurring_tasks_id"
  end
end
