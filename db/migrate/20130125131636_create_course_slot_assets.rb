class CreateCourseSlotAssets < ActiveRecord::Migration
  def change
  	create_table "slots_assets", :force => true do |t|
    	t.integer  "asset_id",     :null => false
    	t.integer  "slot_id", :null => false
  	end
  	add_index "slots_assets", "asset_id"
  	add_index "slots_assets", "slot_id"
  end
end
