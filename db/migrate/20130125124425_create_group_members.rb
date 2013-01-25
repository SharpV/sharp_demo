class CreateGroupMembers < ActiveRecord::Migration
  def change
    
  	create_table "groups_members", :force => true do |t|
    	t.boolean  "admin",      :default => false
    	t.boolean  "active",     :default => false
    	t.integer  "user_id",                       :null => false
    	t.integer  "group_id",                      :null => false
    	t.string   "note"
    	t.datetime "created_at"
    	t.datetime "updated_at"
  	end

  	add_index "groups_members", ["active"]
  	add_index "groups_members", ["group_id"]
  	add_index "groups_members", ["user_id", "group_id"]
  	add_index "groups_members", ["user_id"]

  end
end
