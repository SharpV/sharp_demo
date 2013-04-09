class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer "creator_id"
      t.boolean "is_public", default: false
      t.string  "shareable_type", null: false
      t.integer "shareable_id", null: false
      t.integer  "readings_count",                  :default => 0
      t.integer  "comments_count",                  :default => 0
      t.integer  "likes_count",                     :default => 0
      t.integer  "collections_count",               :default => 0
      t.timestamps
    end
  end
end
