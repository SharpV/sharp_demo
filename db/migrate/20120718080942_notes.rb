class Notes < ActiveRecord::Migration
  def up
    
    create_table "plans", :force => true do |t|
      t.integer "user_id", :null => false
      t.integer "group_id", :null => false
      t.string  "goal"
      t.boolean "done", :default => false
      t.integer "notes_count", :default => 0
      t.integer "user_id"
      t.datetime "done_at"
      t.integer "notes_count", :default => 0
      t.integer "category_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index :plans, :user_id
    add_index :plans, :group_id
    add_index :plans, :category_id

    create_table "notes", :force => true do |t|
      t.text     "body" 
      t.boolean  "active", :default => true
      t.integer  "plan_id"
      t.integer  "group_id"  
      t.datetime "published_at"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "edited_at"
      t.integer  "views_count",                     :default => 0
      t.integer  "comments_count",                  :default => 0
      t.integer  "likes_count",                     :default => 0
      t.integer  "collections_count",               :default => 0
      t.integer  "user_id"
      t.integer "category_id"
    end
    add_index "notes", "plan_id"
    add_index "notes", "group_id"
    add_index "notes", "user_id"
  end

  def down
  end
end
