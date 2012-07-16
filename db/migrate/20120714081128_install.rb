class Install < ActiveRecord::Migration
  def self.up
    create_table "activities", :force => true do |t|
      t.text "content"
      t.integer  "actor_type"
      t.integer  "actor_id"
    end
    
    create_table "domains", :force => true do |t|
      t.integer "parent_id"
      t.string  "name"
      t.integer "lft"
      t.integer "rgt"
      t.integer "users_count",    :default => 0
      t.integer "posts_count",    :default => 0
      t.integer "subjects_count", :default => 0
    end

    add_index "domains", ["parent_id"], :name => "index_grades_on_parent_id"
    

    add_index "activities", :actor_type
    add_index "activities", :actor_id
    add_index :activities, [:actor_type, :actor_id]

    create_table "contacts", :force => true do |t|
      t.integer  "sender_id"
      t.integer  "receiver_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "inverse_id"
      t.integer  "ties_count",  :default => 0
    end

    add_index "contacts", ["inverse_id"], :name => "index_contacts_on_inverse_id"
    add_index "contacts", ["receiver_id"], :name => "index_contacts_on_receiver_id"
    add_index "contacts", ["sender_id"], :name => "index_contacts_on_sender_id"

   
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
      t.integer  "domain_id"
      t.string   "avatar"
      t.integer  "city_code"
      t.integer  "zone_code"
      t.integer  "province_code"
    end
    add_index "users", :province_code
    add_index "users", :city_code
    
    
    create_table "posts", :force => true do |t|
      t.string   "title",                                              :null => false
      t.string   "slug",                                               :null => false
      t.text     "body",                                               :null => false
      t.text     "summary"
      t.boolean  "active",                          :default => true
      t.integer  "post_category_id"
      t.string   "cached_tag_list"
      t.datetime "published_at"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "kind",              :limit => 10,                    :null => false
      t.datetime "edited_at"
      t.integer  "views_count",                     :default => 0
      t.integer  "comments_count",                  :default => 0
      t.integer  "likes_count",                     :default => 0
      t.integer  "collections_count",               :default => 0
      t.string   "file"
      t.string   "link"
      t.integer  "user_id"
      t.string   "image"
      t.boolean  "published",                       :default => false
      t.integer  "grade_id"
      t.integer  "subject_id"
      t.integer  "domain_id"
    end

    add_index "posts", ["domain_id"], :name => "index_posts_on_domain_id"
    add_index "posts", ["grade_id"], :name => "index_posts_on_grade_id"
    add_index "posts", ["kind"], :name => "index_posts_on_kind"
    add_index "posts", ["post_category_id"], :name => "index_posts_on_post_category_id"
    add_index "posts", ["subject_id"], :name => "index_posts_on_subject_id"
    add_index "posts", ["user_id"], :name => "index_posts_on_user_id"


  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
