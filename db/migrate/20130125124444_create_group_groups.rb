class CreateGroupGroups < ActiveRecord::Migration
  def change
     create_table "groups", :force => true do |t|
   		 t.integer  "creator_id"
    	t.datetime "created_at"
    	t.datetime "updated_at"
    	t.string   "name"
    	t.text     "body"
    	t.integer  "groups_members_count",            :default => 0
    	t.string   "logo"
    	t.boolean  "published",            :default => true
  	end

  	add_index "groups", "creator_id"

  end
end
