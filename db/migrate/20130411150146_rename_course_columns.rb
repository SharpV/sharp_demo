class RenameCourseColumns < ActiveRecord::Migration
  def up
    add_column :courses, :slot_id, :integer, null: false
    remove_column :courses, :cousers_members_count
    remove_column :courses, :readings_count
    remove_column :courses, :likes_count
    remove_column :courses, :slots_count
    remove_column :courses, :promo_video
    remove_column :courses, :price
    remove_column :courses, :avatar
    remove_column :courses, :collections_count
    add_column :courses, :webclass_id, :integer, null: false

    add_index :courses, :webclass_id
    add_index :courses, :slot_id

    remove_column :terms, :webclass_id
    add_column :terms, :webclass_id, :integer, null: false
  end

  def down
  end
end
