class AddZone < ActiveRecord::Migration
  def up
    create_table "provinces", :force => true do |t|
      t.string  "name"
      t.string  "mark"
      t.integer "code", :null => false
    end
    
    create_table "cities", :force => true do |t|
      t.integer "province_code"
      t.integer "code",          :null => false
      t.string  "name"
    end
    
    create_table "zones", :force => true do |t|
      t.integer  "code",       :null => false
      t.string   "name",       :null => false
      t.integer  "city_code",  :null => false
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "zones", ["city_code"], :name => "index_zones_on_city_code"
  end

  def down
  end
end
