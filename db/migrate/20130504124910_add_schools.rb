class AddSchools < ActiveRecord::Migration
  def up
    create_table :schools do |t|
      t.string  "name"
      t.integer "province_id"
      t.integer "city_id"
      t.integer "zone_id"
      t.text "address"
      t.string "phone"
      t.timestamps
    end
  end

  def down
  end
end
