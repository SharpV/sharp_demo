class CreateSchoolClasses < ActiveRecord::Migration
  def change

  	create_table "school_classes", :force => true do |t|
    	t.integer "school_grade_id"
    	t.string  "name"
    	t.integer "lft"
    	t.integer "rgt"
    	t.integer "school_id"
    	t.integer "creator_id"
    	t.timestamps
  	end
  	add_index "school_classes", "school_grade_id"
  	add_index "school_classes", "creator_id"
  	add_index "school_classes", "school_id" 
  end
end
