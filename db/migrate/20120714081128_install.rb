class Install < ActiveRecord::Migration
  def self.up
    
    create_table "categories", :force => true do |t|
      t.integer "parent_id"
      t.string  "name"
      t.integer "lft"
      t.integer "rgt"
      t.integer "user_id"
      t.integer "group_id"
    end
    
    add_index :categories, :parent_id
    add_index :categories, :group_id

    
    create_table "documents", :force => true do |t|
      t.integer  "likes_count", :default => 0
      t.string   "name"
      t.string   "file"
      t.text     "summary"
      t.integer  "downloadings_count", :default => 0
      t.integer  "category_id"
      t.integer  "group_id"
      t.integer  "user_id"
      t.integer  "readings_count", :default => 0
    end
    
    add_index :documents, :category_id
    add_index :documents, :group_id    
    add_index :documents, :user_id
    
    create_table "groups", :force => true do |t|
      t.string   "name"
      t.string   "permalink",                                                   :null => false
      t.boolean  "public",          :default => false
      t.integer  "user_id",         :null => false
      t.string  "kind"
      t.integer  "group_members_count", :default => 0
      t.text     "description"
      t.string   "logo"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "settings"
      t.boolean  "deleted",           :default => false,                        :null => false
    end

    add_index "groups", "deleted"
    add_index "groups", "user_id"
    add_index "groups", "kind"
    add_index "groups", "permalink"
  
    
    create_table "group_members", :force => true do |t|
      t.boolean  "admin",          :default => false
      t.boolean  "active",          :default => false
      t.integer  "user_id",         :null => false
      t.integer  "group_id",         :null => false
      t.string     "note"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "group_members", "group_id"
    add_index "group_members", "user_id"
    add_index "group_members", ["user_id", "group_id"]
    add_index "group_members", "active"
   
    create_table "profiles", :force => true do |t|
      t.integer  "user_id"
      t.date     "birthday"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "organization", :limit => 45
      t.string   "phone",        :limit => 45
      t.string   "mobile",       :limit => 45
      t.string   "fax",          :limit => 45
      t.string   "address"
      t.string   "city"
      t.string   "zipcode",      :limit => 45
      t.string   "province",     :limit => 45
      t.string   "country",      :limit => 45
      t.integer  "prefix_key"
      t.string   "description"
      t.string   "experience"
      t.string   "website"
      t.string   "skype",        :limit => 45
      t.string   "im",           :limit => 45
    end
    add_index "profiles", ["user_id"]
  
    create_table "users", :force => true do |t|
      t.string   "name"
      t.string   "login"        
      t.integer  "views_count",          :default => 0,     :null => false
      t.integer  "reputation",           :default => 0
      t.integer  "field_id"
      t.string   "avatar"
      t.integer  "city_code"
      t.integer  "zone_code"
      t.integer  "province_code"
    end
    add_index "users", :province_code
    add_index "users", :city_code
    add_index "users", :field_id
    
    create_table "posts", :force => true do |t|
      t.string   "title",                                              :null => false
      t.text     "body",                                               :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "comments_count",                  :default => 0
      t.integer  "likes_count",                     :default => 0
      t.integer  "collections_count",               :default => 0
      t.datetime  "done_at"
      t.string   "kind"
      t.string   "link"
      t.integer  "user_id"
      t.integer "group_id"
      t.integer "category_id"
      t.integer  "done",          :default => 0
      
    end
    
    add_index "posts", :category_id
    add_index "posts", :group_id
    add_index "posts", :user_id
    add_index "posts", :kind
    

  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
