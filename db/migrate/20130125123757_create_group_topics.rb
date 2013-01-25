class CreateGroupTopics < ActiveRecord::Migration
  def change
    
  	create_table "group_topics", :force => true do |t|
    	t.integer  "user_id",     :null => false
    	t.integer  "group_id",    :null => false
    	t.string   "title"
    	t.text     "body"
    	t.integer  "readings_count",     :default => 0
    	t.integer  "comments_count",     :default => 0
    	t.integer  "category_id"
    	t.datetime "created_at"
    	t.datetime "updated_at"
    	t.boolean  "published",            :default => true
  	end

  	add_index "group_topics", "group_id"
  	add_index "group_topics", "user_id"
  end
end
