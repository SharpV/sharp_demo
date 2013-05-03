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

ActiveRecord::Schema.define(:version => 20130503114516) do

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

  create_table "activities", :force => true do |t|
    t.integer  "actor_id",   :null => false
    t.string   "actor_type", :null => false
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "activities", ["actor_id", "actor_type"], :name => "index_activities_on_actor_id_and_actor_type"

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

  create_table "albums", :force => true do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.integer  "albumable_id"
    t.boolean  "is_public",      :default => true
    t.string   "albumable_type"
    t.integer  "images_count",   :default => 0
    t.datetime "created_at"
    t.integer  "image_id"
  end

  add_index "albums", ["albumable_type", "albumable_id"], :name => "index_albums_on_albumable_type_and_albumable_id"
  add_index "albums", ["creator_id"], :name => "index_albums_on_creator_id"

  create_table "answers", :force => true do |t|
    t.text     "body"
    t.boolean  "accept",      :default => false
    t.datetime "accept_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "close",       :default => false
    t.integer  "question_id",                    :null => false
    t.integer  "likes_count", :default => 0
    t.integer  "bounty",      :default => 0
    t.integer  "user_id",                        :null => false
    t.integer  "up_votes",    :default => 0,     :null => false
    t.integer  "down_votes",  :default => 0,     :null => false
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_ask_id"

  create_table "assignments", :force => true do |t|
    t.boolean  "active",     :default => false
    t.integer  "creator_id",                    :null => false
    t.integer  "group_id",                      :null => false
    t.string   "title"
    t.datetime "created_at"
    t.datetime "submit_at"
    t.text     "body"
    t.integer  "course_id"
    t.integer  "term_id",                       :null => false
  end

  add_index "assignments", ["active"], :name => "index_groups_members_on_active"
  add_index "assignments", ["creator_id", "group_id"], :name => "index_groups_members_on_user_id_and_group_id"
  add_index "assignments", ["creator_id"], :name => "index_groups_members_on_user_id"
  add_index "assignments", ["group_id"], :name => "index_assignments_on_group_id"
  add_index "assignments", ["group_id"], :name => "index_assignments_on_webclass_id"
  add_index "assignments", ["group_id"], :name => "index_groups_members_on_group_id"

  create_table "categories", :force => true do |t|
    t.string  "name"
    t.string  "categoryable_type"
    t.integer "categoryable_id"
    t.integer "creator_id"
    t.integer "posts_count",       :default => 0
  end

  add_index "categories", ["categoryable_id", "categoryable_type"], :name => "index_categories_on_categoryable_id_and_categoryable_type"

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                           :default => "comments"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

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
    t.integer  "creator_id",                       :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "slug"
    t.string   "name",                             :null => false
    t.text     "body"
    t.boolean  "published",     :default => false
    t.integer  "lessons_count", :default => 0
    t.integer  "group_id",                         :null => false
    t.integer  "term_id",                          :null => false
  end

  add_index "courses", ["creator_id"], :name => "index_courses_on_creator_id"
  add_index "courses", ["group_id"], :name => "index_courses_on_group_id"
  add_index "courses", ["group_id"], :name => "index_courses_on_webclass_id"
  add_index "courses", ["term_id"], :name => "index_courses_on_term_id"

  create_table "courses_properties", :force => true do |t|
    t.string  "property_id", :null => false
    t.integer "course_id",   :null => false
  end

  add_index "courses_properties", ["course_id"], :name => "index_courses_properties_on_course_id"
  add_index "courses_properties", ["property_id"], :name => "index_courses_properties_on_property_id"

  create_table "exams", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "body"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "group_id",   :null => false
    t.integer  "term_id",    :null => false
    t.integer  "creator_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "course_id"
  end

  add_index "exams", ["group_id", "term_id"], :name => "index_exams_on_webclass_id_and_term_id"
  add_index "exams", ["group_id"], :name => "index_exams_on_group_id"
  add_index "exams", ["group_id"], :name => "index_exams_on_webclass_id"
  add_index "exams", ["term_id"], :name => "index_exams_on_term_id"

  create_table "folders", :force => true do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.integer  "folderable_id"
    t.boolean  "is_public",       :default => false
    t.string   "folderable_type"
    t.integer  "media_count",     :default => 0
    t.datetime "created_at"
  end

  add_index "folders", ["folderable_type", "folderable_id"], :name => "index_folders_on_folderable_type_and_folderable_id"

  create_table "followings", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "followings", ["followed_user_id", "follower_id"], :name => "index_followings_on_followed_user_id_and_follower_id", :unique => true
  add_index "followings", ["followed_user_id"], :name => "index_followings_on_followed_user_id"
  add_index "followings", ["follower_id"], :name => "index_followings_on_follower_id"

  create_table "follows", :force => true do |t|
    t.integer  "actor_id",                         :null => false
    t.string   "actor_type",                       :null => false
    t.integer  "follower_id",                      :null => false
    t.string   "follower_type",                    :null => false
    t.boolean  "blocked",       :default => false, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "follows", ["actor_id", "actor_type"], :name => "index_follows_on_actor_id_and_actor_type"
  add_index "follows", ["follower_id", "follower_type"], :name => "index_follows_on_follower_id_and_follower_type"

  create_table "grades", :force => true do |t|
    t.string  "name"
    t.integer "parent_id"
    t.integer "position",        :default => 0
    t.integer "posts_count",     :default => 0
    t.integer "media_count",     :default => 0
    t.integer "questions_count", :default => 0
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
  end

  create_table "groups", :force => true do |t|
    t.integer  "creator_id",                        :null => false
    t.integer  "members_count",  :default => 0
    t.string   "avatar"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "slug"
    t.string   "name",                              :null => false
    t.text     "body"
    t.boolean  "published",      :default => false
    t.integer  "readings_count", :default => 0
    t.integer  "media_count",    :default => 0
    t.integer  "likes_count",    :default => 0
    t.integer  "posts_count",    :default => 0
    t.integer  "sections_count", :default => 0
    t.integer  "adviser_id"
    t.integer  "year",           :default => 2013
    t.boolean  "is_class",       :default => false
  end

  create_table "guests", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "guestable_id"
    t.string   "guestable_type"
  end

  add_index "guests", ["guestable_type", "guestable_id"], :name => "index_guests_on_guestable_type_and_guestable_id"
  add_index "guests", ["user_id"], :name => "index_guests_on_user_id"

  create_table "images", :force => true do |t|
    t.integer  "creator_id"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "content_type"
    t.string   "file"
    t.boolean  "is_public",      :default => true
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.integer  "likes_count",    :default => 0
    t.integer  "comments_count", :default => 0
    t.integer  "readings_count", :default => 0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "title"
  end

  create_table "lessons", :force => true do |t|
    t.integer  "slot_id",         :null => false
    t.integer  "course_id",       :null => false
    t.string   "group_id",        :null => false
    t.datetime "start_at"
    t.datetime "created_at"
    t.integer  "slots_course_id", :null => false
  end

  add_index "lessons", ["group_id"], :name => "index_lessons_on_group_id"
  add_index "lessons", ["group_id"], :name => "index_lessons_on_webclass_id"
  add_index "lessons", ["slot_id"], :name => "index_lessons_on_slot_id"

  create_table "media", :force => true do |t|
    t.integer  "creator_id"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "content_type"
    t.string   "file"
    t.string   "play_path"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "is_public",       :default => false
    t.integer  "comments_count",  :default => 0
    t.integer  "mediumable_id"
    t.string   "mediumable_type"
    t.integer  "likes_count",     :default => 0
    t.integer  "readings_count",  :default => 0
    t.integer  "grade_id"
    t.integer  "subject_id"
    t.string   "title"
  end

  add_index "media", ["creator_id"], :name => "index_medias_on_user_id"
  add_index "media", ["grade_id"], :name => "index_media_on_grade_id"
  add_index "media", ["mediumable_type", "mediumable_id"], :name => "index_media_on_mediumable_type_and_mediumable_id"
  add_index "media", ["subject_id"], :name => "index_media_on_subject_id"

  create_table "members", :force => true do |t|
    t.boolean  "admin",                    :default => false
    t.boolean  "active",                   :default => false
    t.integer  "user_id",                                         :null => false
    t.integer  "group_id",                                        :null => false
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",       :limit => 10, :default => "teacher", :null => false
    t.integer  "student_id"
  end

  add_index "members", ["group_id"], :name => "index_members_on_group_id"

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.string   "title",                           :null => false
    t.datetime "send_at"
    t.integer  "group_id"
    t.integer  "recipient_id"
    t.boolean  "read",         :default => false
    t.integer  "sender_id",                       :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "is_draft",     :default => false
    t.boolean  "is_delete",    :default => false
    t.integer  "parent_id"
  end

  add_index "messages", ["group_id"], :name => "index_messages_on_group_id"
  add_index "messages", ["parent_id"], :name => "index_messages_on_parent_id"

  create_table "posts", :force => true do |t|
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
    t.integer  "postable_id"
    t.string   "postable_type"
    t.string   "slug"
    t.integer  "category_id"
    t.boolean  "is_public",                       :default => false
    t.integer  "creator_id",                                         :null => false
    t.boolean  "is_delete",                       :default => false
    t.integer  "grade_id"
    t.integer  "subject_id"
  end

  add_index "posts", ["category_id"], :name => "index_posts_on_category_id"
  add_index "posts", ["grade_id"], :name => "index_posts_on_grade_id"
  add_index "posts", ["kind"], :name => "index_posts_on_kind"
  add_index "posts", ["postable_type", "postable_id"], :name => "index_posts_on_postable_type_and_postable_id"
  add_index "posts", ["subject_id"], :name => "index_posts_on_subject_id"

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
    t.integer  "notifications_count",                :default => 0
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

  create_table "questions", :force => true do |t|
    t.text     "body"
    t.boolean  "published",      :default => true
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_public",      :default => false
    t.integer  "readings_count", :default => 0
    t.integer  "answers_count",  :default => 0
    t.integer  "likes_count",    :default => 0
    t.integer  "answer_id"
    t.integer  "bounty",         :default => 0
    t.integer  "user_id",                           :null => false
    t.integer  "up_votes",       :default => 0,     :null => false
    t.integer  "down_votes",     :default => 0,     :null => false
    t.integer  "grade_id"
    t.integer  "subject_id"
  end

  add_index "questions", ["grade_id"], :name => "index_questions_on_grade_id"
  add_index "questions", ["subject_id"], :name => "index_questions_on_subject_id"
  add_index "questions", ["user_id"], :name => "index_asks_on_user_id"

  create_table "reports", :force => true do |t|
    t.integer  "course_id",  :null => false
    t.integer  "exam_id",    :null => false
    t.integer  "value"
    t.integer  "term_id",    :null => false
    t.integer  "group_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "member_id",  :null => false
  end

  add_index "reports", ["group_id", "term_id"], :name => "index_reports_on_webclass_id_and_term_id"
  add_index "reports", ["group_id"], :name => "index_reports_on_group_id"
  add_index "reports", ["group_id"], :name => "index_reports_on_webclass_id"
  add_index "reports", ["term_id"], :name => "index_reports_on_term_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "sections", :force => true do |t|
    t.integer  "term_id",                   :null => false
    t.string   "timeslot"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "start_at"
    t.integer  "seq",        :default => 0
    t.integer  "creator_id",                :null => false
    t.datetime "end_at"
    t.integer  "group_id",                  :null => false
  end

  add_index "sections", ["group_id"], :name => "index_sections_on_group_id"
  add_index "sections", ["term_id"], :name => "index_slots_on_term_id"

  create_table "slots", :force => true do |t|
    t.integer "course_id",  :null => false
    t.integer "section_id", :null => false
    t.integer "week",       :null => false
    t.integer "term_id",    :null => false
  end

  add_index "slots", ["course_id", "section_id"], :name => "index_slots_courses_on_course_id_and_slot_id"
  add_index "slots", ["section_id", "course_id"], :name => "index_slots_on_section_id_and_course_id"

  create_table "subjects", :force => true do |t|
    t.string  "name"
    t.integer "grade_id"
    t.integer "position",        :default => 0
    t.integer "posts_count",     :default => 0
    t.integer "media_count",     :default => 0
    t.integer "questions_count", :default => 0
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

  create_table "terms", :force => true do |t|
    t.integer  "year",                    :null => false
    t.integer  "part",       :limit => 2, :null => false
    t.datetime "created_at"
    t.integer  "creator_id",              :null => false
    t.integer  "group_id",                :null => false
  end

  add_index "terms", ["group_id"], :name => "index_terms_on_group_id"
  add_index "terms", ["year", "part"], :name => "index_terms_on_year_and_part"

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
    t.string   "name"
    t.integer  "up_votes",                              :default => 0,           :null => false
    t.integer  "down_votes",                            :default => 0,           :null => false
    t.string   "role",                   :limit => 10,  :default => "teacher",   :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"
  add_index "users", ["status"], :name => "index_users_on_status"

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

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
