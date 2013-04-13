class AddEndAtToSlots < ActiveRecord::Migration
  def change
    add_column :slots, :end_at, :datetime
    remove_column :slots, :webclass_id
    add_column :slots, :webclass_id, :integer, null: false
    remove_column :slots, :week
    add_column :lessons, :week, :integer, null: false
    remove_column :courses, :slot_id
    add_column :lessons, :day, :date
  end
end
