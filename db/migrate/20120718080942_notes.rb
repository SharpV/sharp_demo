class Notes < ActiveRecord::Migration
  def up
    
    create_table "plans", :force => true do |t|
      t.integer "user_id", :null => false
      t.string  "goal"
      t.integer "done", :default => 0
      t.integer "notes_count", :default => 0
      t.integer "user_id"
      t.datetime "done_at"
      t.integer "notes_count", :default => 0
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index :plans, :user_id

    create_table "notes", :force => true do |t|
      t.text     "body",                                               :null => false
      t.boolean  "active",                          :default => true
      t.integer  "plan_id"
      t.datetime "published_at"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "edited_at"
      t.integer  "views_count",                     :default => 0
      t.integer  "comments_count",                  :default => 0
      t.integer  "likes_count",                     :default => 0
      t.integer  "collections_count",               :default => 0
      t.integer  "user_id"
      t.boolean  "published",                       :default => false
    end
    add_index "notes", "plan_id"
    add_index "notes", "user_id"
  end

  def down
  end
end
