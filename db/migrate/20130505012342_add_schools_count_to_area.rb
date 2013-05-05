class AddSchoolsCountToArea < ActiveRecord::Migration
  def change
    add_column :cities, :schools_count, :integer, default: 0
    add_column :zones, :schools_count, :integer, default: 0
    add_column :provinces, :schools_count, :integer, default: 0

    add_column :groups, :school_id, :integer

    add_column :users, :zone_id, :integer
    add_column :users, :city_id, :integer 
    add_column :users, :province_id, :integer
    add_index :users, :zone_id
    add_index :users, :city_id
    add_index :users, :province_id

  end
end
