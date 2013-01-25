class CreateShareCategories < ActiveRecord::Migration
  def change
    create_table "share_categories", :force => true do |t|
    	t.integer "parent_id"
    	t.string  "name"
    	t.integer "lft"
    	t.integer "rgt"
    	t.integer "user_id"
  	end
  	add_index "share_categories", "user_id"
  	add_index "share_categories", "parent_id"

  end
end
