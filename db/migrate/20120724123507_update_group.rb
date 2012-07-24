class UpdateGroup < ActiveRecord::Migration
  def up
    add_column :groups, :kind, :string
    add_index :groups, :kind
    
    create_table "pictures", :force => true do |t|
      t.string   "title",                                              :null => false
      t.string   "note"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "comments_count",                  :default => 0
      t.integer  "likes_count",                     :default => 0
      t.integer  "collections_count",               :default => 0
      t.string   "image"
      t.integer  "user_id"
      t.integer "group_id"
      t.integer "category_id"
    end
    
    add_index "pictures", :category_id
    add_index "pictures", :group_id
    add_index "pictures", :user_id
    
    create_table "activities", :force => true do |t|
      t.string   "title",                                              :null => false
      t.string   "body"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "comments_count",                  :default => 0
      t.string   "user_avatar"
      t.string   "group_logo"
      t.integer  "user_id"
      t.integer "group_id"
    end
    
    add_index "activities", :group_id
    add_index "activities", :user_id
    
    create_table "questions", :force => true do |t|
      t.string   "title",                                              :null => false
      t.string   "note"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "comments_count",                  :default => 0
      t.integer  "likes_count",                     :default => 0
      t.integer  "collections_count",               :default => 0
      t.string   "image"
      t.integer  "user_id"
      t.integer "group_id"
      t.integer "category_id"
    end
    
    add_index "questions", :category_id
    add_index "questions", :group_id
    add_index "questions", :user_id
    
    
  end

  def down
  end
end
