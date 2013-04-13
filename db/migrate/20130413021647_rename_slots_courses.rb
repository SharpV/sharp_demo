class RenameSlotsCourses < ActiveRecord::Migration
  def up
    drop_table :sections
    rename_table :slots, :sections
    rename_table :slots_courses, :slots
    rename_column :slots, :slot_id, :section_id
    add_index :slots, [:section_id, :course_id] 
  end

  def down
  end
end
