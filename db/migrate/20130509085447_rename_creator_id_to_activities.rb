class RenameCreatorIdToActivities < ActiveRecord::Migration
  def up
    rename_column :activities, :content, :title
    add_column :activities, :group_id, :integer
    add_index :activities, :group_id
  end

  def down
  end
end
