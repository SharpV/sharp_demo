class CreateCourseSlots < ActiveRecord::Migration
  def change
    create_table "slots", :force => true do |t|
    	t.integer  "creator_id"
    	t.integer  "section_id"
    	t.integer  "course_id"
    	t.string   "title"
    	t.string   "file"
    	t.string   "kind"
    	t.float    "timeslot"
    	t.text     "description"
    	t.datetime "created_at"
    	t.datetime "updated_at"
  	end

  	add_index "slots", "course_id"
  	add_index "slots", "section_id"
  	add_index "slots", "creator_id"
  end
end
