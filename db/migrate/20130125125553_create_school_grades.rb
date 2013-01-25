class CreateSchoolGrades < ActiveRecord::Migration
  def change
    create_table "school_grades", :force => true do |t|
    	t.integer "parent_id"
    	t.string  "name"
    	t.integer "lft"
    	t.integer "rgt"
    	t.integer "school_id"
    	t.integer "creator_id"
  	end
  	add_index "school_grades", "parent_id"
  	add_index "school_grades", "creator_id"
  	add_index "school_grades", "school_id" 
  end
end
