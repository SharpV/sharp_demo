class CreateCourseCourses < ActiveRecord::Migration
  def change
    create_table "courses", :force => true do |t|
    	t.integer  "creator_id",         :null => false
    	t.integer  "course_category_id", :null => false
    	t.integer  "students_count", :default => 0
    	t.decimal  "price",          :default => 0
    	t.string   "promo_video"
    	t.string   "cover"
    	t.datetime "created_at",                        :null => false
    	t.datetime "updated_at",                        :null => false
    	t.string   "slug"
    	t.string   "name",                              :null => false
    	t.text     "body"
    	t.boolean  "published",      :default => false
    	t.integer  "readings_count",    :default => 0
    	t.integer  "comments_count",    :default => 0
    	t.integer  "likes_count",       :default => 0
    	t.integer  "collections_count", :default => 0
  	end

  	add_index "courses", "course_category_id"
  	add_index "courses", "creator_id"  
  end
end
