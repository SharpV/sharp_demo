class ChangeProfileColumn < ActiveRecord::Migration
  def up
    remove_column :profiles, :description
    remove_column :profiles, :name
    add_column :users, :description, :string
    create_table "asks", :force => true do |t|
      t.text     "body"
      t.boolean  "published",         :default => true
      t.string   "title"
      t.string   "slug"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "is_public",         :default => false
      t.integer  "readings_count",    :default => 0
      t.integer  "answers_count",     :default => 0
      t.integer  "likes_count",       :default => 0
      t.integer  "answer_id" 
      t.integer  "bounty",            :default => 0
      t.integer  "user_id",           :null => false
    end

    add_index :asks, :user_id

    create_table "answers", :force => true do |t|
      t.text     "body"
      t.boolean  "accept",            :default => false
      t.datetime "accept_at"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "close",             :default => false
      t.integer  "ask_id",            null: false
      t.integer  "likes_count",       :default => 0
      t.integer  "vote",              :default => 0
      t.integer  "bounty",            :default => 0
      t.integer  "user_id",           :null => false
    end

    add_index :answers, :ask_id


    create_table "group_categories", :force => true do |t|
      t.string  "name"
      t.integer "group_id", null: false
      t.integer "user_id", null: false
    end
    add_index :group_categories, :group_id
  
  end

  def down
  end
end
