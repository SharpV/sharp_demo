class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer  "slot_id", null: false
      t.integer  "course_id", null: false
      t.string   "webclass_id", null: false
      t.datetime "start_at"
      t.datetime "created_at"
    end
    add_index :lessons, :webclass_id
    add_index :lessons, :slot_id

    drop_table :slots

    create_table "slots", :force => true do |t|
      t.integer  "year", null: false
      t.integer  "day", null: false
      t.string   "timeslot"
      t.string   "title"
      t.string   "webclass_id", null: false
      t.datetime "created_at"
      t.datetime "start_at"
      t.integer  "seq", default: 0
      t.integer  "creator_id", null: false
    end

    add_index :slots, :year
    add_index :slots, :week
    add_index :slots, :day
    add_index :slots, :webclass_id
  end
end
