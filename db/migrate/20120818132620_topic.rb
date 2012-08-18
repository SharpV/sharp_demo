class Topic < ActiveRecord::Migration
  def up
    create_table "questions", :force => true do |t|
      t.string   "title",                            :null => false
      t.text     "body",                             :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "comments_count",    :default => 0
      t.integer  "likes_count",       :default => 0
      t.integer  "reading_count", :default => 0
      t.datetime "answered_at"
      t.string   "kind"
      t.integer  "user_id"
      t.integer  "group_id"
      t.integer  "category_id"
    end

    add_index :questions, :user_id
    add_index :questions, :group_id
    add_index :questions, :category_id


    create_table "tasks", :force => true do |t|
      t.string   "title",                            :null => false
      t.text     "body",                             :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "comments_count",    :default => 0
      t.integer  "likes_count",       :default => 0
      t.integer  "reading_count", :default => 0
      t.datetime "done_at"
      t.string   "kind"
      t.integer  "user_id"
      t.integer  "group_id"
      t.integer  "category_id"
      t.integer  "done",              :default => 0
    end

    add_index :tasks, :user_id
    add_index :tasks, :group_id
    add_index :tasks, :category_id

    create_table "albums", :force => true do |t|
      t.integer  "user_id",     :null => false
      t.integer  "group_id",    :null => false
      t.string   "title"
      t.text     "body"
      t.integer  "likes_count",       :default => 0
      t.integer  "reading_count", :default => 0
      t.integer  "comments_count", :default => 0
      t.integer  "category_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index :albums, :user_id
    add_index :albums, :group_id
    add_index :albums, :category_id

    create_table "images", :force => true do |t|
      t.string   "title"
      t.string   "file"
      t.integer  "user_id",     :null => false
      t.integer  "group_id",    :null => false
      t.integer  "likes_count",       :default => 0
      t.integer  "reading_count", :default => 0
      t.integer  "comments_count", :default => 0
      t.integer  "category_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index :images, :user_id
    add_index :images, :group_id
    add_index :images, :category_id


  end

  def down
  end
end
