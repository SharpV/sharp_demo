# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120716091045) do

  create_table "activities", :force => true do |t|
    t.text    "content"
    t.integer "actor_type"
    t.integer "actor_id"
  end

  add_index "activities", ["actor_id"], :name => "index_activities_on_actor_id"
  add_index "activities", ["actor_type", "actor_id"], :name => "index_activities_on_actor_type_and_actor_id", :unique => true
  add_index "activities", ["actor_type"], :name => "index_activities_on_actor_type"

  create_table "cities", :force => true do |t|
    t.integer "province_code"
    t.integer "code",          :null => false
    t.string  "name"
  end

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

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "provinces", :force => true do |t|
    t.string  "name"
    t.string  "mark"
    t.integer "code", :null => false
  end

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
    t.string   "name"
    t.string   "login"
    t.integer  "views_count",            :default => 0,  :null => false
    t.integer  "reputation",             :default => 0
    t.string   "avatar"
    t.integer  "city_code"
    t.integer  "zone_code"
    t.integer  "province_code"
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["city_code"], :name => "index_users_on_city_code"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["province_code"], :name => "index_users_on_province_code"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "zones", :force => true do |t|
    t.integer  "code",       :null => false
    t.string   "name",       :null => false
    t.integer  "city_code",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "zones", ["city_code"], :name => "index_zones_on_city_code"

end
