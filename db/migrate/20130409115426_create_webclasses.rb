class CreateWebclasses < ActiveRecord::Migration
  def change
    drop_table :course_discusses
    rename_column :groups, :groups_members_count, :members_count
    create_table :webclasses do |t|
      t.integer  "creator_id",                               :null => false
      t.integer  "members_count", :default => 0
      t.string   "avatar"
      t.datetime "created_at",                               :null => false
      t.datetime "updated_at",                               :null => false
      t.string   "slug"
      t.string   "name",                                     :null => false
      t.text     "body"
      t.boolean  "published",             :default => false
      t.integer  "readings_count",        :default => 0
      t.integer  "comments_count",        :default => 0
      t.integer  "likes_count",           :default => 0
      t.integer  "collections_count",     :default => 0
      t.integer  "sections_count",        :default => 0
      t.integer  "adviser_id"
    end
  end

  create_table "members", :force => true do |t|
    t.boolean  "admin",      :default => false
    t.boolean  "active",     :default => false
    t.integer  "user_id",                       :null => false
    t.integer  "memberable_id",                 :null => false
    t.string   "memberable_type", null: false
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
