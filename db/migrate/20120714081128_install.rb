class Install < ActiveRecord::Migration
  def self.up
  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table :assets do |t|
      t.references :assetable, :polymorphic => true
      t.string :file_name
      t.integer :file_size
      t.string :file_type
      t.string :file
      t.string :play_path
      t.timestamps
  end
  add_index :assets, :assetable_id
  add_index :assets, :assetable_type

  create_table "categories", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.integer "lft"
    t.integer "rgt"
    t.references :categoryable, :polymorphic => true
    t.integer "depth"
  end

  add_index "categories", ["categoryable_id"], :name => "index_categories_on_categoryable_id"
  add_index "categories", ["categoryable_type"], :name => "index_categories_on_categoryable_type"
  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"

  create_table "connections", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "connections", ["provider"], :name => "index_connections_on_provider"
  add_index "connections", ["uid"], :name => "index_connections_on_uid"
  add_index "connections", ["user_id"], :name => "index_connections_on_user_id"

  create_table "courses", :force => true do |t|
    t.integer  "creator_id",                           :null => false
    t.integer  "students_count",    :default => 0
    t.decimal  "price",             :default => 0.0
    t.string   "promo_video"
    t.string   "cover"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "slug"
    t.string   "name",                                 :null => false
    t.text     "body"
    t.boolean  "published",         :default => false
    t.integer  "readings_count",    :default => 0
    t.integer  "comments_count",    :default => 0
    t.integer  "likes_count",       :default => 0
    t.integer  "collections_count", :default => 0
  end

  add_index "courses", ["creator_id"], :name => "index_courses_on_creator_id"

  create_table "courses_properties", :force => true do |t|
    t.string  "property_id", :null => false
    t.integer "course_id",   :null => false
  end

  add_index "courses_properties", ["course_id"], :name => "index_courses_properties_on_course_id"
  add_index "courses_properties", ["property_id"], :name => "index_courses_properties_on_property_id"

  create_table "followings", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "followings", ["followed_user_id", "follower_id"], :name => "index_followings_on_followed_user_id_and_follower_id", :unique => true
  add_index "followings", ["followed_user_id"], :name => "index_followings_on_followed_user_id"
  add_index "followings", ["follower_id"], :name => "index_followings_on_follower_id"

  create_table "group_topics", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.integer  "group_id",                         :null => false
    t.string   "title"
    t.text     "body"
    t.integer  "readings_count", :default => 0
    t.integer  "comments_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",      :default => true
  end

  add_index "group_topics", ["group_id"], :name => "index_group_topics_on_group_id"
  add_index "group_topics", ["user_id"], :name => "index_group_topics_on_user_id"

  create_table "groups", :force => true do |t|
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "body"
    t.integer  "groups_members_count", :default => 0
    t.string   "logo"
    t.boolean  "published",            :default => true
  end

  add_index "groups", ["creator_id"], :name => "index_groups_on_creator_id"

  create_table "groups_members", :force => true do |t|
    t.boolean  "admin",      :default => false
    t.boolean  "active",     :default => false
    t.integer  "user_id",                       :null => false
    t.integer  "group_id",                      :null => false
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups_members", ["active"], :name => "index_groups_members_on_active"
  add_index "groups_members", ["group_id"], :name => "index_groups_members_on_group_id"
  add_index "groups_members", ["user_id", "group_id"], :name => "index_groups_members_on_user_id_and_group_id"
  add_index "groups_members", ["user_id"], :name => "index_groups_members_on_user_id"

  create_table "posts", :force => true do |t|
    t.text     "body"
    t.boolean  "published",                       :default => true
    t.string   "kind",              :limit => 10
    t.string   "title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "edited_at"
    t.integer  "readings_count",                  :default => 0
    t.integer  "comments_count",                  :default => 0
    t.integer  "likes_count",                     :default => 0
    t.integer  "collections_count",               :default => 0
    t.string   "file"
    t.integer  "user_id",                                           :null => false
  end

  add_index "posts", ["kind"], :name => "index_posts_on_kind"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organization",         :limit => 45
    t.string   "phone",                :limit => 45
    t.string   "mobile",               :limit => 45
    t.string   "identity_card",        :limit => 45
    t.string   "address"
    t.string   "name"
    t.integer  "notifications_count",                :default => 0
    t.string   "description"
    t.integer  "city_code"
    t.integer  "zone_code"
    t.string   "experience"
    t.string   "website"
    t.string   "qq",                   :limit => 45
    t.integer  "posts_count",                        :default => 0
    t.integer  "courses_count",                      :default => 0
    t.integer  "groups_count",                       :default => 0
    t.integer  "likes_count",                        :default => 0
    t.integer  "school_classes_count",               :default => 0
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_actor_id"

  create_table "properties", :force => true do |t|
    t.string "key",   :null => false
    t.string "value", :null => false
  end

  add_index "properties", ["key"], :name => "index_properties_on_key"

  create_table "school_classes", :force => true do |t|
    t.integer  "school_grade_id"
    t.string   "name"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "school_id"
    t.integer  "creator_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "school_classes", ["creator_id"], :name => "index_school_classes_on_creator_id"
  add_index "school_classes", ["school_grade_id"], :name => "index_school_classes_on_school_grade_id"
  add_index "school_classes", ["school_id"], :name => "index_school_classes_on_school_id"

  create_table "school_grades", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.integer "lft"
    t.integer "rgt"
    t.integer "school_id"
    t.integer "creator_id"
  end

  add_index "school_grades", ["creator_id"], :name => "index_school_grades_on_creator_id"
  add_index "school_grades", ["parent_id"], :name => "index_school_grades_on_parent_id"
  add_index "school_grades", ["school_id"], :name => "index_school_grades_on_school_id"

  create_table "sections", :force => true do |t|
    t.string  "title",                    :null => false
    t.integer "course_id",                :null => false
    t.integer "position",  :default => 0
  end

  add_index "sections", ["course_id"], :name => "index_sections_on_course_id"

  create_table "slots", :force => true do |t|
    t.integer  "creator_id"
    t.integer  "section_id"
    t.integer  "course_id"
    t.string   "title"
    t.string   "file"
    t.string   "kind"
    t.float    "timeslot"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slots", ["course_id"], :name => "index_slots_on_course_id"
  add_index "slots", ["creator_id"], :name => "index_slots_on_creator_id"
  add_index "slots", ["section_id"], :name => "index_slots_on_section_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "encrypted_password",     :limit => 128, :default => "",          :null => false
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
    t.string   "email"
    t.string   "nickname"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.string   "login",                                                          :null => false
    t.datetime "locked_at"
    t.string   "status",                                :default => "available"
    t.string   "avatar"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"
  add_index "users", ["status"], :name => "index_users_on_status"

  end
end
