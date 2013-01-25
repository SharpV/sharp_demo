class CreateCourseProperties < ActiveRecord::Migration
  def change
  	create_table "properties", :force => true do |t|
    	t.string   "key",                  :null => false
    	t.string  "value",                 :null => false
  	end
    add_index "properties", "key"

  	create_table "courses_properties", :force => true do |t|
    	t.string   "property_id",                :null => false
    	t.integer  "course_id",                  :null => false
  	end
  	add_index "courses_properties", "property_id"
  	add_index "courses_properties", "course_id"
  end
end
