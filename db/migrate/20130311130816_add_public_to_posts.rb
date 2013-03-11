class AddPublicToPosts < ActiveRecord::Migration
  def change
    create_table "bookmarks", :force => true do |t|
      t.text     "body"
      t.boolean  "published",                       default: true
      t.string   "title"
      t.string   "slug"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "is_public",                       default: false
      t.integer  "readings_count",                  default: 0
      t.integer  "comments_count",                  default: 0
      t.integer  "likes_count",                     default: 0
      t.integer  "collections_count",               default: 0
      t.string   "origin_url"
      t.integer  "user_id",          null: false
    end

    add_index :bookmarks, :user_id

    add_column :posts, :is_public, :boolean, default: false
    add_column :media, :is_public, :boolean, default: false
    add_column :folders, :is_public, :boolean, default: false
  end
end
