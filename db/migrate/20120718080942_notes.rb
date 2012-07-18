class Notes < ActiveRecord::Migration
  def up

    create_table "note_categories", :force => true do |t|
      t.integer "parent_id"
      t.string  "name"
      t.integer "lft"
      t.integer "rgt"
      t.integer "user_id"
      t.integer "notes_count", :default => 0
    end

    add_index :note_categories, :user_id

    create_table "notes", :force => true do |t|
      t.string   "title",                                              :null => false
      t.string   "slug",                                               :null => false
      t.text     "body",                                               :null => false
      t.text     "summary"
      t.boolean  "active",                          :default => true
      t.integer  "note_category_id"
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
      t.integer  "subject_id"
    end

    add_index "notes", "kind"
    add_index "notes", "note_category_id"
    add_index "notes", "user_id"
    add_index "notes", "subject_id"
  end

  def down
  end
end
