class CreateSharePosts < ActiveRecord::Migration
  def change
    create_table "share_posts", :force => true do |t|
   		t.text     "body"
   		t.boolean  "published",            :default => true
    	t.string   "kind"
   		t.string   "title"
    	t.datetime "created_at"
    	t.datetime "updated_at"
    	t.datetime "edited_at"
    	t.integer  "readings_count",    :default => 0
    	t.integer  "comments_count",    :default => 0
    	t.integer  "likes_count",       :default => 0
    	t.integer  "collections_count", :default => 0
    	t.integer  "user_id"
    	t.integer  "share_category_id"
    	t.string   "file"
  	end

  	add_index "share_posts", "kind"
  	add_index "share_posts", "user_id"
  	add_index "share_posts", "share_category_id"
  end
end
