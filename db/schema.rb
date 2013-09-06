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

ActiveRecord::Schema.define(:version => 20130906014724) do

  create_table "crawler_meta", :force => true do |t|
    t.string   "url"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "crawler_meta", ["status"], :name => "index_crawler_meta_on_status"
  add_index "crawler_meta", ["url"], :name => "index_crawler_meta_on_url"

  create_table "product_images", :force => true do |t|
    t.string   "file"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "product_images", ["product_id"], :name => "index_product_images_on_product_id"

  create_table "product_manuals", :force => true do |t|
    t.integer  "product_id"
    t.string   "file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "product_manuals", ["product_id"], :name => "index_manuals_on_product_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
    t.text     "recommended_items"
    t.text     "related_items"
    t.text     "coordinating_items"
    t.decimal  "price",              :precision => 8, :scale => 2
    t.integer  "reviews_count",                                    :default => 0
  end

  add_index "products", ["category_id"], :name => "index_products_on_category_id"

  create_table "reviews", :force => true do |t|
    t.text     "body"
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
    t.integer  "product_id"
    t.string   "slug"
    t.integer  "category_id"
    t.boolean  "is_public",                       :default => false
    t.integer  "user_id",                                            :null => false
    t.boolean  "is_delete",                       :default => false
    t.integer  "skill_id"
  end

  add_index "reviews", ["category_id"], :name => "index_posts_on_category_id"
  add_index "reviews", ["kind"], :name => "index_posts_on_kind"
  add_index "reviews", ["product_id"], :name => "index_posts_on_group_id"
  add_index "reviews", ["skill_id"], :name => "index_posts_on_column_id"
  add_index "reviews", ["user_id"], :name => "index_posts_on_user_id"

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
    t.string   "description"
    t.string   "provider"
    t.integer  "posts_value",                           :default => 0,           :null => false
    t.integer  "recommends_count",                      :default => 0,           :null => false
    t.string   "role",                   :limit => 10,  :default => "teacher",   :null => false
    t.integer  "skills_count",                          :default => 0
    t.integer  "zone_id"
    t.integer  "city_id"
    t.integer  "province_id"
    t.integer  "posts_count",                           :default => 0
    t.integer  "media_count",                           :default => 0
    t.integer  "questions_count",                       :default => 0
    t.integer  "answers_count",                         :default => 0
    t.integer  "albums_count",                          :default => 0
    t.integer  "question_value",                        :default => 0
    t.integer  "activities_count",                      :default => 0
    t.integer  "readings_count",                        :default => 0
    t.string   "uid"
    t.integer  "media_value",                           :default => 0
  end

  add_index "users", ["city_id"], :name => "index_users_on_city_id"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["province_id"], :name => "index_users_on_province_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"
  add_index "users", ["status"], :name => "index_users_on_status"
  add_index "users", ["zone_id"], :name => "index_users_on_zone_id"

  create_table "votings", :force => true do |t|
    t.string   "voteable_type"
    t.integer  "voteable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "up_vote",       :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "votings", ["voteable_type", "voteable_id", "voter_type", "voter_id"], :name => "unique_voters", :unique => true
  add_index "votings", ["voteable_type", "voteable_id"], :name => "index_votings_on_voteable_type_and_voteable_id"
  add_index "votings", ["voter_type", "voter_id"], :name => "index_votings_on_voter_type_and_voter_id"

end
