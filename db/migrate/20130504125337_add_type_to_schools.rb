class AddTypeToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :level, :integer, limit: 1
    add_index :schools, :level
    add_index :schools, :city_id
    add_index :schools, :province_id
    add_index :schools, :zone_id
    add_column :schools, :groups_counter, :integer, default: 0
  end
end
