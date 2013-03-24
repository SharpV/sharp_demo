class CreateCoursesMembers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :groups, :need_check_when_apply, :boolean, default: false
    rename_column :courses, :students_count, :users_count
    create_table "courses_members", :force => true do |t|
      t.boolean  "admin",      :default => false
      t.boolean  "active",     :default => false
      t.integer  "user_id",                       :null => false
      t.integer  "course_id",                      :null => false
      t.string   "note"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index :courses_members, :user_id
    add_index :courses_members, :course_id
  end
end
