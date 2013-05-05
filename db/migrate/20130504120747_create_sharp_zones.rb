class CreateSharpZones < ActiveRecord::Migration
  def self.up
    create_table "cities", :force => true do |t|
      t.integer "province_id",          :null => false
      t.string  "name"
      t.timestamps
    end
    add_index "cities", "province_id"

    create_table "provinces", :force => true do |t|
      t.string  "name"
      t.timestamps
    end

    create_table "zones", :force => true do |t|
      t.string   "name",       :null => false
      t.integer  "city_id",  :null => false
      t.timestamps
    end
    add_index "zones", "city_id"
  end

  def self.down
    drop_table :cities
    drop_table :provinces
    drop_table :zones
  end
end
