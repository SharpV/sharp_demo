class AddWeekAndTermToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :term_id, :integer, null: false
    add_index :courses, :term_id
    remove_column :courses, :comments_count
    rename_column :courses, :sections_count, :lessons_count
    remove_column :lessons, :week
    remove_column :lessons, :day
    add_column :lessons, :slots_course_id, :integer, null: false

    create_table "slots_courses", :force => true do |t|
      t.integer  "course_id", null: false
      t.integer  "slot_id", null: false
      t.integer  "week", null: false
      t.integer  "term_id", null: false
    end
    add_index :slots_courses, [:course_id, :slot_id]
  end
end
