class CreateFriendships < ActiveRecord::Migration
  def change
    create_table "followings", :force => true do |t|
    	t.integer  "follower_id"
    	t.integer  "followed_user_id"
    	t.datetime "created_at",       :null => false
    	t.datetime "updated_at",       :null => false
  	end

  	add_index "followings", ["followed_user_id", "follower_id"], :name => "index_followings_on_followed_user_id_and_follower_id", :unique => true
  	add_index "followings", ["followed_user_id"], :name => "index_followings_on_followed_user_id"
  	add_index "followings", ["follower_id"], :name => "index_followings_on_follower_id"

  end
end
