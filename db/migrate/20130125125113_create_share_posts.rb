class CreateSharePosts < ActiveRecord::Migration
  def change
    create_table "posts", :force => true do |t|
   		t.text     "body"
   		t.boolean  "published",            :default => true
    	t.integer   "kind",                :limit => 1, :deault => 0
   		t.string   "title"
      t.string   "url"
    	t.datetime "created_at"
    	t.datetime "updated_at"
    	t.datetime "edited_at"
    	t.integer  "readings_count",    :default => 0
    	t.integer  "comments_count",    :default => 0
    	t.integer  "likes_count",       :default => 0
    	t.integer  "collections_count", :default => 0
    	t.string   "file"
      t.integer  "user_id", :null => false
  	end

  	add_index "posts", "kind"
  	add_index "posts", "user_id"
  end
end
