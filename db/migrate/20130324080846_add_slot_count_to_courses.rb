class AddSlotCountToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :sections_count, :integer, default: 0
    add_column :courses, :slots_count, :integer, default: 0
  end
end
