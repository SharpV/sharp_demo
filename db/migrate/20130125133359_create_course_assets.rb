class CreateCourseAssets < ActiveRecord::Migration
  def change
  	create_table "assets", :force => true do |t|
    	t.datetime "created_at"
    	t.string   "file"
  	end
  end
end
