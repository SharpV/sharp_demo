class RenameWebclassIdToGroupId < ActiveRecord::Migration
  def up
    rename_column :assignments, :webclass_id, :group_id
    add_index :assignments, :group_id


    rename_column :courses, :webclass_id, :group_id
    add_index :courses, :group_id


    rename_column :exams, :webclass_id, :group_id
    add_index :exams, :group_id


    rename_column :lessons, :webclass_id, :group_id
    add_index :lessons, :group_id


    rename_column :messages, :webclass_id, :group_id
    add_index :messages, :group_id

    rename_column :reports, :webclass_id, :group_id
    add_index :reports, :group_id

    rename_column :terms, :webclass_id, :group_id
    add_index :terms, :group_id

    rename_column :sections, :webclass_id, :group_id
    add_index :sections, :group_id

  end

  def down
  end
end
