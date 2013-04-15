class RenameMemberIdToWebclassIdMessages < ActiveRecord::Migration
  def up
    rename_column :messages, :member_id, :webclass_id
  end

  def down
  end
end
