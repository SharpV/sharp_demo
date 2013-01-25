class CreateCourseCategories < ActiveRecord::Migration
  def change
    create_table :course_categories do |t|
		t.integer "parent_id"
    	t.string  "name"
    	t.integer "lft"
    	t.integer "rgt"
    end

    add_index "course_categories", "parent_id"
  end
end
