class CreateCourseSections < ActiveRecord::Migration
  def change
    create_table "sections", :force => true do |t|
    	t.string   "title",   :null => false
    	t.integer  "course_id",   :null => false
    	t.integer  "position", :default => 0
  	end
  	add_index "sections", "course_id"

  end
end
