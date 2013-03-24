class CreateDiscusses < ActiveRecord::Migration
  def change
    rename_column :courses, :users_count, :cousers_members_count

    create_table "course_categories", :force => true do |t|
      t.string  "name"
      t.integer "course_id", :null => false
      t.integer "user_id",  :null => false
    end
    add_index :course_categories, :course_id
    add_index :course_categories, :user_id

    create_table "course_discusses", :force => true do |t|
      t.integer  "user_id",                         :null => false
      t.integer  "course_id",                       :null => false
      t.integer  "slot_id"
      t.integer  "course_category_id"
      t.string   "title"
      t.text     "body"
      t.integer  "readings_count", :default => 0
      t.integer  "comments_count", :default => 0
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "parent_id"
      t.integer  "lft"
      t.integer  "rgt"
      t.integer  "depth"
      t.boolean  "delete",      :default => false
    end
    add_index :course_discusses, :user_id
    add_index :course_discusses, :course_category_id
    add_index :course_discusses, :course_id
    add_index :course_discusses, :slot_id

  end
end
